import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

typedef CommandAction0<Output extends Object> = Future<Result<Output>>
    Function();
typedef CommandAction1<Output extends Object, Input extends Object>
    = Future<Result<Output>> Function(Input);

abstract class Command<Output extends Object> extends ChangeNotifier {
  bool _running = false;

  bool get running => _running;

  Result<Output>? _result;

  Result<Output>? get result => _result;

  bool get completed => _result is Success;

  bool get error => _result is Failure;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<Output> action) async {
    if (running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<Output extends Object> extends Command {
  final CommandAction0<Output> action;

  Command0(this.action);

  Future<void> execute() async {
    await _execute(() => action());
  }
}

class Command1<Output extends Object, Input extends Object> extends Command {
  final CommandAction1<Output, Input> action;

  Command1(this.action);

  Future<void> execute(Input params) async {
    await _execute(() => action(params));
  }
}
