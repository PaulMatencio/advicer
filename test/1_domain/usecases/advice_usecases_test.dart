import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUseCases', () {
    group('should return AdviceEntity', () {
      test('when AdviceRepoImpl returns a AdviceModel', () async {
        //!  mock AdviceRepoImpl
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        //!  create an instance of  AdviceUserCases
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource(null))
            .thenAnswer((realInvocation) => Future.value(const Right(AdviceEntity(advice: 'test', id: 42))));
        //!  getAdvice()
        final result = await adviceUseCaseUnderTest.getAdvice(null);

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, const Right<Failure, AdviceEntity>(AdviceEntity(advice: 'test', id: 42)));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource(null)).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead .called(0)
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource(null))
            .thenAnswer((realInvocation) => Future.value(Left(ServerFailure(message: null))));

        final result = await adviceUseCaseUnderTest.getAdvice(null);

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result.runtimeType, Left<Failure, AdviceEntity>(ServerFailure(message: null)).runtimeType);
        verify(mockAdviceRepoImpl.getAdviceFromDatasource(null)).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

      test('a GeneralFailure', () async {
        // arrange
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource(null))
            .thenAnswer((realInvocation) => Future.value(Left(GeneralFailure())));

        // act
        dynamic  result = await adviceUseCaseUnderTest.getAdvice(null);
        result = await adviceUseCaseUnderTest.getAdvice(null);
        // assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result.runtimeType, Left<Failure, AdviceEntity>(GeneralFailure()).runtimeType);
        verify(mockAdviceRepoImpl.getAdviceFromDatasource(null)).called(2);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });
  });
}