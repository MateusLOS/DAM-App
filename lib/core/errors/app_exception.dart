abstract class AppException implements Exception {
  final String message;
  const AppException({required this.message});

  @override
  String toString() {
    return 'AppException: $message';
  }
}

class AuthException extends AppException {
  const AuthException({required String message}) : super(message: message);
}

class NetworkException extends AppException {
  const NetworkException({required String message}) : super(message: message);
}