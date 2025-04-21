import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class LogoutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LogoutViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    logout = Command0<Unit>(_logout);
  }

  late Command0 logout;
  String? erroMensage;

  Future<Result<Unit>> _logout() async {
    final result = await _authRepository.logout();
    result.fold((success) {}, (error) {
      erroMensage = (error as AppFailure).errorMessage;
    });
    notifyListeners();
    return result.map((_) => unit);
  }
}
