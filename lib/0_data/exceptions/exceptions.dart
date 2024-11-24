
class ServerException implements Exception {
  final String  ? message;
  ServerException({required this.message});
}

class CacheExceptions implements Exception {}

class DataExceptions implements Exception{
  final String message;
  DataExceptions({required this.message});
}