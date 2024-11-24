
import '../entities/advice_entity.dart';
import '../failures/failures.dart';
import 'package:dartz/dartz.dart';


abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource(int ? id);
}

