import 'package:enxoval_baby/app/core/utils/validators/text_validator.dart';

class PasswordValidator implements TextValidator {
  @override
  bool isValidText({required String text}) {
    return text.length >= 6 &&
        _senhaContemLetraMaiuscula(text) &&
        _senhaContemMinuscula(text) &&
        _senhaContemNumero(text);
  }

  bool _senhaContemNumero(String text) {
    RegExp regex = RegExp(r'\d');

    bool contemNumeros = regex.hasMatch(text);

    if (contemNumeros) {
      return true;
    } else {
      return false;
    }
  }

  bool _senhaContemLetraMaiuscula(String text) {
    RegExp regex = RegExp(r'[A-Z]');

    bool contemLetraMaiuscula = regex.hasMatch(text);

    if (contemLetraMaiuscula) {
      return true;
    } else {
      return false;
    }
  }

  bool _senhaContemMinuscula(String text) {
    RegExp regex = RegExp(r'[a-z]');

    bool contemLetraMinuscula = regex.hasMatch(text);

    if (contemLetraMinuscula) {
      return true;
    } else {
      return false;
    }
  }
}
