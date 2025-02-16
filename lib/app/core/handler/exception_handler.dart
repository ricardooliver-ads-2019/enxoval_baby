import 'dart:developer';

class ExceptionHandler {
  final List<Exception? Function(Exception, StackTrace)> _customHandlers;

  ExceptionHandler({List<Exception? Function(Exception, StackTrace)>? handlers})
      : _customHandlers = handlers ?? [];

  Exception handle(Exception exception, StackTrace stackTrace) {
    for (final handler in _customHandlers) {
      final result = handler(exception, stackTrace);
      if (result != null) {
        _logError(result, stackTrace);
        return result;
      }
    }
    _logError(exception, stackTrace);
    throw '';
  }

  void _logError(Exception exception, StackTrace stackTrace) {
    // Exemplo de log detalhado
    log(
      'Erro: ${exception.toString()}\nStackTrace: ${stackTrace.toString()}',
      name: 'ExceptionHandler',
    );
  }
}
