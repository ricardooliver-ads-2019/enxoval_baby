import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;
  bool isLoading = false;
  bool isSuccess = false;
  String? erroMensage;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    final result =
        await _authRepository.login(email: email, password: password);

    result.fold((success) {
      isLoading = false;
      isSuccess = true;
    }, (error) {
      isLoading = false;
      erroMensage = (error as AppFailure).errorMessage;
    });
    notifyListeners();
  }
}
