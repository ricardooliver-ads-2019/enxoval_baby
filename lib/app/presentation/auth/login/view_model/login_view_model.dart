import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    login = Command1(_login);
  }

  late Command1<void, (String email, String password)> login;

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    return await _authRepository.login(UserCredentialDto(
      email: email,
      password: password,
    ));
  }
}
