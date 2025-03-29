// ignore_for_file: library_prefixes

import 'package:enxoval_baby/app/core/failures/app_failure.dart' as appFailures;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

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
            errorMessage: 'Usuario não encontrado',
          ),
        );
      }

      return Success(result.user!);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<User> loginGoogle({required AuthCredential credential}) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        return Failure(
          appFailures.AuthException(
            errorMessage: 'Usuario não encontrado',
          ),
        );
      }

      return Success(result.user!);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> logout() async {
    try {
      await _auth.signOut();
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
