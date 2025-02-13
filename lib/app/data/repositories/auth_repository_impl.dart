import 'package:enxoval_baby/app/core/utils/failures/app_failure.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _authDataSource;
  final ValueNotifier<bool> _isAuthNotifier = ValueNotifier<bool>(false);
  AuthRepositoryImpl({
    required FirebaseAuthDatasource auth,
  }) : _authDataSource = auth {
    _authDataSource.authStateChanges.listen((user) {
      final userModel = user != null ? UserModel.fromFirebase(user) : null;
      _isAuthNotifier.value = userModel != null;
    });
  }

  @override
  ValueNotifier<bool> get isAuth => _isAuthNotifier;

  @override
  Stream<UserEntity?> get authStateChanges =>
      _authDataSource.authStateChanges.map((user) {
        return user != null ? UserModel.fromFirebase(user) : null;
      });

  @override
  AsyncResult<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _authDataSource.login(email: email, password: password);
      final user = UserModel.fromFirebase(result.getOrThrow());
      return Success(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Failure(AuthException(errorMessage: 'Email não encontrado!'));
      } else if (e.code == 'wrong-password') {
        return Failure(AuthException(errorMessage: 'Senha incorreta!'));
      } else if (e.code == 'invalid-credential') {
        return Failure(
            AuthException(errorMessage: 'Email ou Senha incorretos!'));
      } else {
        throw '';
      }
    } catch (e) {
      _isAuthNotifier.value = false;
      throw '';
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    try {
      return await _authDataSource.logout();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Failure(AuthException(errorMessage: 'Email não encontrado!'));
      } else if (e.code == 'wrong-password') {
        return Failure(AuthException(errorMessage: 'Senha incorreta!'));
      } else if (e.code == 'invalid-credential') {
        return Failure(
            AuthException(errorMessage: 'Email ou Senha incorretos!'));
      } else {
        throw '';
      }
    }
  }
}
