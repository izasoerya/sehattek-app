import 'package:sehattek_app/core/utils/enumeration.dart';

class ErrorWrapper {
  final String message;
  final ErrorType? type;

  const ErrorWrapper({required this.message, required this.type});

  static ErrorWrapper unknownError(String message) {
    return ErrorWrapper(message: message, type: ErrorType.unknown);
  }

  static ErrorWrapper networkError(String message) {
    return ErrorWrapper(message: message, type: ErrorType.network);
  }

  static ErrorWrapper serverError(String message) {
    return ErrorWrapper(message: message, type: ErrorType.server);
  }

  static ErrorWrapper validationError(String message) {
    return ErrorWrapper(message: message, type: ErrorType.validation);
  }
}
