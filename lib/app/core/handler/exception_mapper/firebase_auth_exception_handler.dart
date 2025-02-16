import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionHandler implements ExceptionMapper {
  @override
  Exception? mapException(Exception e, StackTrace stackTrace) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return AuthException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage: 'Email ou Senha incorretos!',
          );
        default:
          throw 'Erro não tratado no FirebaseAuthException';
      }
    } else {
      return null;
    }
  }
}
