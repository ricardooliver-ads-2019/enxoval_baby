import 'package:enxoval_baby/app/utils/validators/validation_messages_enum.dart';
import 'package:enxoval_baby/app/utils/validators/validators/email_validator.dart';
import 'package:enxoval_baby/app/utils/validators/validators/full_name_validator.dart';
import 'package:enxoval_baby/app/utils/validators/validators/name_validator.dart';
import 'package:enxoval_baby/app/utils/validators/validators_null.dart';

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

  String? genericValidator(String? text, [int minLength = 3]) {
    if (ValidatorsNull.isNotNullAndNotEmpty(text)) {
      if (text!.length < minLength) {
        return ValidationMessagesEnum
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
}
