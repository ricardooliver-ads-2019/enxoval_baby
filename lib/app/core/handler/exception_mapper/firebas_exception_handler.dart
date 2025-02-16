import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionHandler implements ExceptionMapper {
  @override
  Exception? mapException(Exception e, StackTrace stackTrace) {
    if (e is FirebaseException && e is! FirebaseAuthException) {
      switch (e.code) {
        case 'storage/retry-limit-exceeded':
          return FireStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'O limite de tempo em uma operação (upload, download, exclusão etc.) foi excedido. Envie novamente.',
          );
        case 'storage/unauthorized':
          return FireStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'O usuário não está autorizado a executar a ação desejada. Verifique se as regras de segurança estão corretas.',
          );
        case 'storage/unauthenticated':
          return FireStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'O usuário não está autenticado. Faça a autenticação e tente novamente.',
          );
        case 'storage/unknown':
          return FireStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage: 'Ocorreu um erro desconhecido.',
          );
        case 'storage/object-not-found':
          return FireStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage: 'Nenhum objeto na referência desejada.',
          );

        default:
          throw 'FirebaseException';
      }
    } else {
      return null;
    }
  }
}
