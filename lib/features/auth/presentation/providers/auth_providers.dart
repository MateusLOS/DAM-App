import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recomendou_flutter/features/auth/domain/entities/user.dart';
import 'package:recomendou_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:recomendou_flutter/features/auth/domain/usecases/register_usecase.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.user, this.isLoading = false, this.errorMessage});

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthProvider extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthProvider({required this.loginUseCase, required this.registerUseCase}) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await loginUseCase.execute(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await registerUseCase.execute(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    // Implementar lógica de logout (se necessário)
    state = state.copyWith(user: null);
  }
}

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  // Obter instâncias dos UseCases a partir do GetIt
  return AuthProvider(
    loginUseCase: ref.read(loginUseCaseProvider),
    registerUseCase: ref.read(registerUseCaseProvider),
  );
});

// Providers para os UseCases
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(authRepository: ref.read(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(authRepository: ref.read(authRepositoryProvider));
});

// Provider para o AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(dataSource: FirebaseAuthDataSource());
});