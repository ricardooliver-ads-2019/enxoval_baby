// ignore_for_file: library_prefixes

import 'package:enxoval_baby/app/core/utils/failures/failure.dart'
    as appFailures;
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
}
