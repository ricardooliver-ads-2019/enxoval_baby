import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ForgotPasswordViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    resetPassword = Command1<Unit, String>(_resetPassword);
  }
  late Command1 resetPassword;
  String? erroMensage;

  Future<Result<Unit>> _resetPassword(
    String email,
  ) async {
    final result = await _authRepository.resetPassword(email: email);

    result.fold((success) {}, (error) {
      erroMensage = (error as AppFailure).errorMessage;
    });
    notifyListeners();
    return result.map((_) => unit);
  }
}
