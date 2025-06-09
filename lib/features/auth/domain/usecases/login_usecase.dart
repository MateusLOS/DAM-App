import 'package:recomendou_flutter/features/auth/domain/entities/user.dart';
import 'package:recomendou_flutter/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<User> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}