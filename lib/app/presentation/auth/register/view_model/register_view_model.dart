import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  RegisterViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    register = Command1<void, (String email, String password)>(_register);
  }

  late Command1 register;


  Future<Result<void>> _register((String, String) credentials) async {
    final (email, password) = credentials;
    return await _authRepository.register(UserCredentialDto(
      email: email,
      password: password,
    ));
    
  }
}
