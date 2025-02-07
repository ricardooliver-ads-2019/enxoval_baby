import 'package:enxoval_baby/app/utils/validators/validators/text_validator.dart';

class FullNameValidator implements TextValidator {
  final _minLengthValidator = 3;

  @override
  bool isValidText({required String text}) {
    final regex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)+$');
    final nameParts = text.trim().split(RegExp(r'\s+'));

    final hasValidLength =
        nameParts.every((name) => name.length >= _minLengthValidator);

    return regex.hasMatch(text) && hasValidLength;
  }
}
