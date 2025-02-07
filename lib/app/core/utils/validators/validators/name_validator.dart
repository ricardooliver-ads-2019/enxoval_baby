import 'package:enxoval_baby/app/core/utils/validators/validators/text_validator.dart';

class NameValidator implements TextValidator {
  final _minLengthValidator = 3;

  @override
  bool isValidText({required String text}) {
    final regex = RegExp(r'^[A-Za-z]+$');
    final firstName = text.trim().split(RegExp(r'\s+')).first;

    final isValidName = regex.hasMatch(firstName);

    return text.length < _minLengthValidator && isValidName;
  }
}
