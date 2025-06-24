abstract class AppException implements Exception {
  final String message;
  const AppException({required this.message});

  @override
  String toString() {
    return 'AppException: $message';
  }
}

class AuthException extends AppException {
  const AuthException({required super.message});
}

class NetworkException extends AppException {
  const NetworkException({required super.message});
}