import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';

void main() {
  group("Shoul test Commands", () {
    test('command0 Success', () async {
      final command = Command0<String>(getOkResultCommand0);

      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.result, isNull);
      await command.execute();
      expect(command.running, false);
      expect(command.error, false);
      expect(command.completed, true);
      expect(command.result, isNotNull);
      expect((command.result as Success).getOrNull(), 'Success');
    });

    test('command0 Failure', () async {
      final command = Command0<String>(getFailureResultCommand0);

      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.result, isNull);
      await command.execute();
      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, true);
      expect(command.result, isNotNull);
      expect(command.result!.exceptionOrNull(), isA<Exception>());
    });

    test('command1 Success', () async {
      final command = Command1<String, String>(getOkResultCommand1);

      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.result, isNull);
      await command.execute('Email');
      expect(command.running, false);
      expect(command.error, false);
      expect(command.completed, true);
      expect(command.result, isNotNull);
      expect((command.result as Success).getOrNull(), 'Success: Email');
    });

    test('command1 Failure', () async {
      final command = Command1<String, String>(getFailureResultCommand1);

      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.result, isNull);
      await command.execute('Email');
      expect(command.running, false);
      expect(command.completed, false);
      expect(command.error, true);
      expect(command.result, isNotNull);
      expect(command.result!.exceptionOrNull(), isA<Exception>());
    });
  });
}

AsyncResult<String> getOkResultCommand0() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return const Success('Success');
}

AsyncResult<String> getFailureResultCommand0() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Failure(Exception());
}

AsyncResult<String> getOkResultCommand1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Success('Success: $params');
}

AsyncResult<String> getFailureResultCommand1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Failure(Exception('Error: $params'));
}
