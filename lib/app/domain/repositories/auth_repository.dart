import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AuthRepository {
  Stream<UserCredentialEntity?> get authStateChanges;
  ValueNotifier<bool> get isAuth;
  AsyncResult<UserCredentialEntity> register(
    UserCredentialDto userCredential,
  );
  AsyncResult<UserCredentialEntity> login(
    UserCredentialDto userCredential,
  );

  AsyncResult<Unit> logout();
  AsyncResult<Unit> resetPassword({required String email});
  AsyncResult<Unit> createUser(UserEntity user);
}
