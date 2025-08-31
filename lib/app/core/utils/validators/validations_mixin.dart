import 'package:enxoval_baby/app/core/utils/validation_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/email_validator.dart';
import 'package:enxoval_baby/app/core/utils/validators/full_name_validator.dart';
import 'package:enxoval_baby/app/core/utils/validators/name_validator.dart';
import 'package:enxoval_baby/app/core/utils/validators/password_validator.dart';
import 'package:enxoval_baby/app/core/utils/validators/validators_null.dart';

mixin ValidationsMixin {
  String? nameValidator(String? name, [String? message]) {
    var error = genericValidator(name, 2);

    error ??= NameValidator().isValidText(text: name!)
        ? null
        : ValidationMessagesEnum.porFavorInformeNomeValido.text;

    return error;
  }

  String? fullNameValidator(String? fullName, [String? message]) {
    var error = genericValidator(fullName);

    error ??= FullNameValidator().isValidText(text: fullName!)
        ? null
        : ValidationMessagesEnum.porFavorInformeUmNomeCompleto.text;

    return error;
  }

  String? emailValidator(String? email, [String? message]) {
    var error = genericValidator(email, 5);

    error ??= EmailValidator().isValidText(text: email!)
        ? null
        : ValidationMessagesEnum.porFavorInformeUmEmailValido.text;

    return error;
  }

  String? passwordValidator(String? password, [String? message]) {
    var error = genericValidator(password, 6,
        ValidationMessagesEnum.aSenhaDeveTerNoMinimo6Caracteres.text);

    error ??= PasswordValidator().isValidText(text: password!)
        ? null
        : validations([
            () => _senhaContemNumero(password),
            () => _senhaContemLetraMaiuscula(password),
            () => _senhaContemMinuscula(password),
            () => senhaContemCaracteresEspecial(password),
          ]);

    return error;
  }

  String? _senhaContemNumero(String text) {
    RegExp regex = RegExp(r'\d');

    bool contemNumeros = regex.hasMatch(text);

    if (contemNumeros) {
      return null;
    } else {
      return ValidationMessagesEnum.aSenhaDeveConterNumero.text;
    }
  }

  String? _senhaContemLetraMaiuscula(String text) {
    RegExp regex = RegExp(r'[A-Z]');

    bool contemLetraMaiuscula = regex.hasMatch(text);

    if (contemLetraMaiuscula) {
      return null;
    } else {
      return ValidationMessagesEnum
          .aSenhaDeveConterPeloMenosUmaLentraMaiuscula.text;
    }
  }

  String? _senhaContemMinuscula(String text) {
    RegExp regex = RegExp(r'[a-z]');

    bool contemLetraMinuscula = regex.hasMatch(text);

    if (contemLetraMinuscula) {
      return null;
    } else {
      return ValidationMessagesEnum
          .aSenhaDeveConterPeloMenosUmaLentraMinuscula.text;
    }
  }

  String? senhaContemCaracteresEspecial(String text) {
    RegExp regex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    bool contemCaracterEspecial = regex.hasMatch(text);

    if (contemCaracterEspecial) {
      return null;
    } else {
      return ValidationMessagesEnum
          .aSenhaDeveConterPeloMenosUmCaracterEspecial.text;
    }
  }

  String? genericValidator(String? text, [int minLength = 3, String? message]) {
    if (ValidatorsNull.isNotNullAndNotEmpty(text)) {
      if (text!.length < minLength) {
        return message ??
            ValidationMessagesEnum
                .porFavorPreenchaComAInformacaoSolicitada.text;
      }

      return null;
    } else {
      return ValidationMessagesEnum.campoObrigatorio.text;
    }
  }

  String? validations(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }

  String? dueDateValidator(DateTime? date) {
    if (date == null) {
      return ValidationMessagesEnum.campoObrigatorio.text;
    }

    final now = DateTime.now();
    final oneYearFromNow = DateTime.now().add(const Duration(days: 365));

    if (date.isBefore(now)) {
      return 'A data não pode ser anterior à data atual';
    }

    if (date.isAfter(oneYearFromNow)) {
      return 'A data não pode ser superior a 1 ano a partir de hoje';
    }

    return null;
  }
}
