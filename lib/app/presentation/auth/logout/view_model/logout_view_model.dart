import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LogoutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LogoutViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  bool isLoading = false;
  bool isSuccess = false;
  String? erroMensage;

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();
    final response = await _authRepository.logout();
    response.fold((success) {
      isLoading = false;
      isSuccess = true;
    }, (error) {
      isLoading = false;
      erroMensage = (error as AppFailure).errorMessage;
    });
    notifyListeners();
  }
}
