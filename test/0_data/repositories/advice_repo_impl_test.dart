import 'dart:io';

import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntity', () {
      test('when AdviceRemoteDatasource returns a AdviceModel', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi(null))
            .thenAnswer((realInvocation) => Future.value(AdviceModel(advice: 'test', id: 42)));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource(null);

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, Right<Failure, AdviceModel>(AdviceModel(advice: 'test', id: 42)));
        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi(null)).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });

    group('should return left with', () {

      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi(null)).thenThrow(ServerException(message:null));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource(null);

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result.runtimeType, Left<Failure, AdviceEntity>(ServerFailure(message:null)).runtimeType);
      });


      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi(null)).thenThrow(const SocketException(''));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource(null);

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result.runtimeType, Left<Failure, AdviceEntity>(GeneralFailure()).runtimeType);
      });
    });
  });
}