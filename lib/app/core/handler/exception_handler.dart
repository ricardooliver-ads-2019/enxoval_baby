import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper.dart';
import 'package:enxoval_baby/app/core/log/log_app.dart';

class ExceptionHandler {
  final List<ExceptionMapper> _customHandlers;
  final _logApp = Injection.inject<LogApp>();

  ExceptionHandler({required List<ExceptionMapper> handlers})
      : _customHandlers = handlers;

  Exception handle(Exception exception, StackTrace stackTrace) {
    for (final handler in _customHandlers) {
      final result = handler.mapException(exception, stackTrace);
      if (result != null) {
        _logApp.logError(result, stackTrace);
        return result;
      }
    }
    _logApp.logError(exception, stackTrace);
    throw 'Exception não encontrada';
  }
}
