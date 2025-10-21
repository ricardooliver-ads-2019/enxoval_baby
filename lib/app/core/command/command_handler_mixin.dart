import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:flutter/material.dart';

mixin CommandHandlerMixin<TWidget extends StatefulWidget> on State<TWidget> {
  final List<VoidCallback> _removes = [];

  void handleCommand<TResult>(
    Command<TResult> command, {
    void Function(TResult data)? onSuccess,
    void Function(Exception error)? onError,
    void Function()? retry,
    bool showDefaultSnackBarOnError = true,
  }) {
    void listener() {
      final result = command.result;
      if (result == null) return;

      if (command.error && result is Error<TResult>) {
        onError?.call(result.error);
        if (showDefaultSnackBarOnError) {
          final msg =
              result.error is AppFailure
                  ? (result.error as AppFailure).errorMessage
                  : result.error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg), action: SnackBarAction(label: ErrorMessagesEnum.erro.message, onPressed: retry ?? () {})));
        }
      } else if (command.completed && result is Ok<TResult>) {
        onSuccess?.call(result.value);
      }
    }

    command.addListener(listener);
    _removes.add(() => command.removeListener(listener));
  }

  @override
  void dispose() {
    for (final remove in _removes) remove();
    _removes.clear();
    super.dispose();
  }
}
