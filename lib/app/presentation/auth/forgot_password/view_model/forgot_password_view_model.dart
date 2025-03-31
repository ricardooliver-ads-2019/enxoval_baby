import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ForgotPasswordViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;
  bool isLoading = false;
  bool isSuccess = false;
  String? erroMensage;

  Future<void> resetPassword({
    required String email,
  }) async {
    isLoading = true;
    _reset();
    notifyListeners();
    final result = await _authRepository.resetPassword(email: email);

    result.fold((success) {
      isLoading = false;
      isSuccess = true;
    }, (error) {
      isLoading = false;
      erroMensage = (error as AppFailure).errorMessage;
    });
    notifyListeners();
  }

  void _reset() {
    isSuccess = false;
    erroMensage = null;
  }
}
