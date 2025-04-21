import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  RegisterViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    register = Command1<Unit, (String email, String password)>(_register);
  }

  late Command1 register;
  String? erroMensage;

  Future<Result<Unit>> _register((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.register(UserCredentialDto(
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
