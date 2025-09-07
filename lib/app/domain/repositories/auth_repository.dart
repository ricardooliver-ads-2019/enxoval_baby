import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';


abstract class AuthRepository extends ChangeNotifier {
  Stream<UserCredentialEntity?> get authStateChanges;
  ValueNotifier<bool> get isAuth;
  Future<Result<UserCredentialEntity>> register(
    UserCredentialDto userCredential,
  );
  Future<Result<UserCredentialEntity>> login(
    UserCredentialDto userCredential,
  );

  Future<Result<void>> logout();
  Future<Result<void>> resetPassword({required String email});
  Future<Result<void>> createUser(UserEntity user);
}
