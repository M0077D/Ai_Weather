import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/user_entity.dart';
import 'package:task1/features/weather/domain/usecases/get_user_usecase.dart';

class UserProvider with ChangeNotifier {
  UserEntity? _user;
  bool _isLoading = false;

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;

  final GetUserUseCase getUserUseCase;

  UserProvider({required this.getUserUseCase});

  Future<void> fetchUser() async {
    try {
      _user = await getUserUseCase.execute();
    } catch (e) {
      // Handle errors (e.g., display a snackbar)
      print('Error fetching user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
