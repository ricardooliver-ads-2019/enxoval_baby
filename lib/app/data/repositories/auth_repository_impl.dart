import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _authDataSource;
  final ExceptionHandler _handler;
  final ValueNotifier<bool> _isAuthNotifier = ValueNotifier<bool>(false);
  AuthRepositoryImpl({
    required FirebaseAuthDatasource auth,
    required ExceptionHandler handler,
  })  : _handler = handler,
        _authDataSource = auth {
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
  AsyncResult<UserEntity> register(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.register(
          email: userCredential.email, password: userCredential.password);
      final user = UserModel.fromFirebase(result.getOrThrow());
      return Success(user);
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerRegister;
    }
  }

  @override
  AsyncResult<UserEntity> login(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.login(
          email: userCredential.email, password: userCredential.password);
      final user = UserModel.fromFirebase(result.getOrThrow());
      return Success(user);
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;

      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerLogin.message;
    }
  }

  @override
  AsyncResult<Unit> resetPassword({required String email}) async {
    try {
      return await _authDataSource.resetPassword(email: email);
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerResetPassword;
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    try {
      return await _authDataSource.logout();
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerLogout;
    }
  }
}
