import 'package:firebase_auth/firebase_auth.dart';
import 'package:recomendou_flutter/core/errors/app_exceptions.dart';
import 'package:recomendou_flutter/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:recomendou_flutter/features/auth/data/models/user_model.dart';
import 'package:recomendou_flutter/features/auth/domain/entities/user.dart';
import 'package:recomendou_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<User> login(String email, String password) async {
    try {
      final userCredential = await dataSource.signInWithEmailAndPassword(email, password);
      return UserModel(id: userCredential.user!.uid, email: userCredential.user!.email!);
    } on AuthException catch (e) {
      throw AuthException(message: e.message);
    } catch (e) {
      throw AuthException(message: 'Unexpected error during login');
    }
  }

  @override
  Future<User> register(String email, String password) async {
    try {
      final userCredential = await dataSource.createUserWithEmailAndPassword(email, password);
      return UserModel(id: userCredential.user!.uid, email: userCredential.user!.email!);
    } on AuthException catch (e) {
      throw AuthException(message: e.message);
    } catch (e) {
      throw AuthException(message: 'Unexpected error during registration');
    }
  }

  @override
  Future<void> logout() async {
    await dataSource.signOut();
  }
}