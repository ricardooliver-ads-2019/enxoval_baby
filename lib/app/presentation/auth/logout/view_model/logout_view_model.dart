import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LogoutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LogoutViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    logout = Command0<void>(_logout);
  }

  late Command0 logout;


  Future<Result<void>> _logout() async {
     return  await _authRepository.logout();  
  }
}
