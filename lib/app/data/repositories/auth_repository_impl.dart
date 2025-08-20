import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_credential_model.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/data/models/user_settings_model.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _authDataSource;
  final FirebaseUserDatasource _userDataSource;
  final ExceptionHandler _handler;
  final ValueNotifier<bool> _isAuthNotifier = ValueNotifier<bool>(false);
  AuthRepositoryImpl({
    required FirebaseAuthDatasource auth,
    required FirebaseUserDatasource userDataSource,
    required ExceptionHandler handler,
  })  : _handler = handler,
        _authDataSource = auth,
        _userDataSource = userDataSource {
    _authDataSource.authStateChanges.listen((user) {
      final userModel = user != null ? UserCredentialModel.fromFirebase(user) : null;
      _isAuthNotifier.value = userModel != null;
    });
  }

  @override
  ValueNotifier<bool> get isAuth => _isAuthNotifier;

  @override
  Stream<UserCredentialEntity?> get authStateChanges =>
      _authDataSource.authStateChanges.map((user) {
        return user != null ? UserCredentialModel.fromFirebase(user) : null;
      });

  @override
  AsyncResult<UserCredentialEntity> register(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.register(
          email: userCredential.email, password: userCredential.password);
      final user = UserCredentialModel.fromFirebase(result.getOrThrow());
      await createUser(UserModel.fromEntity(_converteUserCredentialToUserModel(user)));
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
  AsyncResult<UserCredentialEntity> login(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.login(
          email: userCredential.email, password: userCredential.password);
      final user = UserCredentialModel.fromFirebase(result.getOrThrow());
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


   @override
  AsyncResult<Unit> createUser(UserEntity user) async {
    try {
      return await _userDataSource.createUser(UserModel.fromEntity(user));
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecido.message;
    }
  }

  UserModel _converteUserCredentialToUserModel(UserCredentialEntity credential) {
    return UserModel(
      id: credential.id,
      email: credential.email,
      name: credential.name,
      profilePhoto: credential.image,
      settings: const UserSettingsModel(
        notificationsEnabled: true,
        isPremium: false,
        theme: 'neutro'
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
