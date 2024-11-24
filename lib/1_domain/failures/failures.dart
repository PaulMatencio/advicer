abstract class Failure {}

class ServerFailure extends Failure {
  final String ? message;
  ServerFailure({required this.message});
}

class CacheFailure extends Failure {}

class GeneralFailure extends Failure {}


class DataFailure extends Failure {
  final String message;
  DataFailure({required this.message});

}

