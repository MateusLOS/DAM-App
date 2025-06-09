import 'package:recomendou_flutter/features/auth/domain/entities/user.dart';
import 'package:recomendou_flutter/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<User> execute(String email, String password) async {
    return await authRepository.register(email, password);
  }
}