import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';

import '../../1_domain/entities/advice_entity.dart';
import '../../1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import '../../1_domain/repositories/advice_repo.dart';



class AdviceRepoImpl implements AdviceRepo {

 // ! final AdviceRemoteDatasource adviceRemoteDatasource = AdviceRemoteDatasourceImpl();
  final AdviceRemoteDatasource adviceRemoteDatasource;
  AdviceRepoImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource(int ? id) async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi(id);
      return right(result);
    } on Exception catch (e) {
      switch (e) {
        case final  ServerException e:
          return left(ServerFailure(message: e.message));
          // return e.message != null ? left(ServerFailure(message: e.message)): left(ServerFailure(message :null));
        case final DataExceptions e:
          return left(DataFailure(message: e.message));
        case final CacheExceptions _:
          return left(CacheFailure());
        default:
          return left(GeneralFailure());
      }
    }
  }
}


/*
class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDatasource adviceRemoteDatasource =
  AdviceRemoteDatasourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (e) {
      return left(GeneralFailure());
    } on CacheExceptions catch (e) {
      return left(CacheFailure());
    } on DataExceptions catch (e) {
      return left(DataFailure(message: e.message));
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}

 */


