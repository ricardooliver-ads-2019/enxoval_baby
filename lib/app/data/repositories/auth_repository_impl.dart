import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/datasources/local/secure_user_storage.dart';
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

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthDatasource _authDataSource;
  final FirebaseUserDatasource _userDataSource;
  final ExceptionHandler _handler;
  final SecureUserStorage _session;
  final ValueNotifier<bool> _isAuthNotifier = ValueNotifier<bool>(false);
  AuthRepositoryImpl({
    required FirebaseAuthDatasource auth,
    required FirebaseUserDatasource userDataSource,
    required ExceptionHandler handler,
    required SecureUserStorage session,
  })  : _handler = handler,
        _authDataSource = auth,
        _userDataSource = userDataSource,
        _session = session {
    _authDataSource.authStateChanges.listen((user) async {
      final userModel = user != null ? UserCredentialModel.fromFirebase(user) : null;
      
        if (userModel != null) {
          final current = await _session.getCurrentUserId();
          if (current == null || current != userModel.id) {
            await _session.saveCurrentUser(
              id: userModel.id,
              email: userModel.email,
              name: userModel.name,
              photoUrl: userModel.image,
              isPremium: false,
              isNotificationsEnabled: true,
            );
          }
          _isAuthNotifier.value = true;
        } else {
          await _session.clear();
        }
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
  Future<Result<UserCredentialEntity>> register(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.register(
          email: userCredential.email, password: userCredential.password);
      final user = UserCredentialModel.fromFirebase(result.asOk.value);
      await createUser(UserModel.fromEntity(_converteUserCredentialToUserModel(user)));
      await _session.saveCurrentUser(
        id: user.id,
        email: user.email,
        name: user.name,
        photoUrl: user.image,
        isPremium: false,
        isNotificationsEnabled: true,
      );
      return Result.ok(user);
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Result.error(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerRegister;
    }finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<UserCredentialEntity>> login(
    UserCredentialDto userCredential,
  ) async {
    try {
      final result = await _authDataSource.login(
          email: userCredential.email, password: userCredential.password);
      final user = UserCredentialModel.fromFirebase(result.asOk.value);
      // 1) (Opcional) puxe users/{uid} para sincronizar cache de UI
      // 2) Salva snapshot local com UID
      await _session.saveCurrentUser(
        id: user.id, email: user.email, name: user.name, photoUrl: user.image);
      return Result.ok(user);
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Result.error(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;

      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerLogin.message;
    }finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    try {
      final result = await _authDataSource.resetPassword(email: email);
      return Result.ok(result.asOk.value);
    } on Exception catch (e, stack) {
      return Result.error(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerResetPassword;
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _session.clear();
      return await _authDataSource.logout();
    } on Exception catch (e, stack) {
      _isAuthNotifier.value = false;
      return Result.error(_handler.handle(e, stack));
    } catch (e) {
      _isAuthNotifier.value = false;
      notifyListeners();
      throw ErrorMessagesEnum.erroDesconhecidoAoTentarFazerLogout;
    }
  }


   @override
  Future<Result<void>> createUser(UserEntity user) async {
    try {
      return await _userDataSource.createUser(UserModel.fromEntity(user));
    } on Exception catch (e, stack) {
      return Result.error(_handler.handle(e, stack));
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
