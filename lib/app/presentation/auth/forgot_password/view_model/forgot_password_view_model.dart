import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';


class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ForgotPasswordViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    resetPassword = Command1<void, String>(_resetPassword);
  }
  late Command1<void, String> resetPassword;

  String? erroMensage;

  Future<Result<void>> _resetPassword(
    String email,
  ) async {
    final result = await _authRepository.resetPassword(email: email);
    result.fold((success) {}, (err) {
      erroMensage = (err as AppFailure).errorMessage;
      notifyListeners();
    });
    return result;
  }
}
