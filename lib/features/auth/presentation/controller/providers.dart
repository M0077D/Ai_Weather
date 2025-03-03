import 'package:flutter/material.dart';
import 'package:task1/core/usecases/usecase.dart';
import 'package:task1/features/auth/domain/UseCases/get_current_user_use_case.dart';
import 'package:task1/features/auth/domain/UseCases/sign_up_use_case.dart';
import 'package:task1/features/auth/domain/entities/user.dart';
import 'package:task1/features/auth/domain/usecases/sign_in_use_case.dart';

class AuthProvider with ChangeNotifier {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  final GetCurrentUserUseCase getCurrentUserUseCase;

  Userr? _user;
  Userr? get user => _user;

  AuthProvider({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserUseCase,
  });

  Future<void> signIn(String email, String password) async {
    try {
      _user =
          await signInUseCase(SignInParams(email: email, password: password));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String username) async {
    try {
      _user = await signUpUseCase(
          SignUpParams(email: email, password: password, username: username));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getCurrentUser() async {
    try {
      _user = await getCurrentUserUseCase(NoParams());
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
