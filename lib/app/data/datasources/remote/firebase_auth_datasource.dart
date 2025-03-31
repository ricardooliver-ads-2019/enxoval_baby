// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:enxoval_baby/app/core/failures/app_failure.dart' as appFailures;
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AsyncResult<User> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) {
        return Failure(appFailures.AuthException(
            errorMessage: ErrorMessagesEnum.erroAoCriarContaDoUsuario.message));
      }
      return Success(result.user!);
    } on Exception catch (e, stackTrace) {
      log('Erro register: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) {
        return Failure(
          appFailures.AuthException(
              errorMessage: ErrorMessagesEnum
                  .erroAoTentarLoginComEmalUsuarioNaoEncontrado.message),
        );
      }

      return Success(result.user!);
    } on Exception catch (e, stackTrace) {
      log('Erro login: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<User> loginGoogle({required AuthCredential credential}) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        return Failure(
          appFailures.AuthException(
              errorMessage: ErrorMessagesEnum
                  .erroAoTentarLoginComContaGoogleUsuarioNaoEncontrado.message),
        );
      }
      return Success(result.user!);
    } on Exception catch (e, stackTrace) {
      log('Erro loginGoogle: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<Unit> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Success(unit);
    } on Exception catch (e, stackTrace) {
      log('Erro resetPassword: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<Unit> logout() async {
    try {
      await _auth.signOut();
      return const Success(unit);
    } on Exception catch (e, stackTrace) {
      log('Erro logout: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}
