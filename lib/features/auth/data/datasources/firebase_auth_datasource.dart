import 'package:firebase_auth/firebase_auth.dart';
import 'package:recomendou_flutter/core/errors/app_exceptions.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Authentication failed');
    } catch (e) {
      throw AuthException(message: 'Unexpected error during sign-in');
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Registration failed');
    } catch (e) {
      throw AuthException(message: 'Unexpected error during registration');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
