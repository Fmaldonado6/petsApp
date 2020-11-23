class AppError implements Exception {
  String errorMessage;
  AppError(this.errorMessage);
}

class BadInput extends AppError {
  BadInput(String errorMessage) : super(errorMessage);
}

class NotFound extends AppError {
  NotFound(String errorMessage) : super(errorMessage);
}
