sealed class AppException implements Exception {
  AppException(this.message);
  final String message;
}

class EmtyListException extends AppException {
  EmtyListException() : super('List is empty');
}

class UnknownException extends AppException {
  UnknownException() : super('Some error occurred');
}
