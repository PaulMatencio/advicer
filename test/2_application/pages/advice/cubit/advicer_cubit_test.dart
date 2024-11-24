import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('AdvicerCubit', () {
    group(
      'should emit',
          () {
        MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

        blocTest(
          'nothing when no method is called',
          build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
          expect: () => const <AdvicerCubitState>[],
        );

        blocTest(
          '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
          setUp: () => when(() => mockAdviceUseCases.getAdvice(null)).thenAnswer(
                (invocation) => Future.value(
              const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'advice', id: 1),
              ),
            ),
          ),
          build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
          act: (cubit) => cubit.adviceRequested(null),
          expect: () =>  <AdvicerCubitState>[
            //!  expect 2 states
            const AdvicerStateLoading(),
            const AdvicerStateLoaded(advice: 'advice')],
        );

        group(
          '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
              () {
            const String message = 'Socket exception';
            blocTest(
              'and a ServerFailure occurs',
              setUp: () => when(() => mockAdviceUseCases.getAdvice(null)).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    ServerFailure(message: message),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequested(null),
              expect: () => <AdvicerCubitState>[
                const AdvicerStateLoading(),
               //!  const AdvicerStateError(message: serverFailureMessage),
                const AdvicerStateError(message: '$serverFailureMessage => $message'),
              ],
            );

            blocTest(
              'and a CacheFailure occurs',
              setUp: () => when(() => mockAdviceUseCases.getAdvice(null)).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    CacheFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequested(null),
              expect: () => <AdvicerCubitState>[
                const AdvicerStateLoading(),
                const AdvicerStateError(message: cacheFailureMessage),
              ],
            );

            blocTest(
              'and a GeneralFailure occurs',
              setUp: () => when(() => mockAdviceUseCases.getAdvice(null)).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    GeneralFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequested(null),
              expect: () => <AdvicerCubitState>[
                const AdvicerStateLoading(),
                const AdvicerStateError(message: generalFailureMessage),
              ],
            );
          },
        );
      },
    );
  });
}