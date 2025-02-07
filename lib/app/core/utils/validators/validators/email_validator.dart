import 'package:enxoval_baby/app/core/utils/validators/validators/text_validator.dart';

class EmailValidator implements TextValidator {
  @override
  bool isValidText({required String text}) {
    final regex = RegExp(
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");

    return regex.hasMatch(text);
  }
}
