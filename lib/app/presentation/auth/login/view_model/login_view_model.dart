import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    login = Command1(_login);
  }

  late Command1<Unit, (String email, String password)> login;

  String? erroMensage;

  Future<Result<Unit>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.login(UserCredentialDto(
      email: email,
      password: password,
    ));

    result.fold((success) {}, (error) {
      erroMensage = (error as AppFailure).errorMessage;
    });

    notifyListeners();
    return result.map((_) => unit);
  }
}
