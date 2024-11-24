import 'package:dartz/dartz.dart';
import '../../0_data/repositories/advice_repo_impl.dart';
import '../entities/advice_entity.dart';
import '../failures/failures.dart';
import '../repositories/advice_repo.dart';

class AdviceUseCases {
  // call a repository to get data (failure or data)
  // proceed with business logic (manipulate the data)
  //! final adviceRepo  = AdviceRepoImpl(); //  implementation of AdviceRePo
  //!  dependency injection
  //!   sl.registerFactory<AdviceRepo>(
  //!         () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  //!
  final AdviceRepo adviceRepo;
  AdviceUseCases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice(int? id) async {
    return adviceRepo.getAdviceFromDatasource(id);
  }
}
