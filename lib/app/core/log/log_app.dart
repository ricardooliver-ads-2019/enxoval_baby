import 'dart:developer';

class LogApp {
  void logError(Object exception, StackTrace stackTrace) {
    log(
      'Erro: ${exception.toString()}\n StackTrace: ${stackTrace.toString()}',
      name: 'ExceptionHandler',
    );
  }
}
