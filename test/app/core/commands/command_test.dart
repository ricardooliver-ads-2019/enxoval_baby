import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

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
      expect((command.result as Ok).asOk.value, 'Success');
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
      expect(command.result!.asError.error, isA<Exception>());
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
      expect((command.result as Ok).asOk.value, 'Success: Email');
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
      expect(command.result!.asError.error, isA<Exception>());
    });
  });
}

Future<Result<String>> getOkResultCommand0() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok('Success');
}

Future<Result<String>> getFailureResultCommand0() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception());
}

Future<Result<String>> getOkResultCommand1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok('Success: $params');
}

Future<Result<String>> getFailureResultCommand1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception('Error: $params'));
}
