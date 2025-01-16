import 'package:design_system/src/color/colors_export.dart';
import 'package:design_system/src/fontStyle/font_styles_export.dart';
import 'package:design_system/utils/ds_strings.dart';
import 'package:flutter/material.dart';

class DSTextStyle {
  final TextStyle strong;
  final TextStyle semiStrong;
  final TextStyle neutral;
  final TextStyle defaults;
  final TextStyle thin;

  const DSTextStyle._({
    required this.strong,
    required this.semiStrong,
    required this.neutral,
    required this.defaults,
    required this.thin,
  });

  factory DSTextStyle.hero1(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxbig.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxbig.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxbig.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxbig.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxbig.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
    );
  }

  factory DSTextStyle.hero2(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxbig.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxbig.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxbig.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxbig.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxbig.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xxlarge.value : null,
        color: textColor,
      ),
    );
  }

  factory DSTextStyle.headline1(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xbig.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xlarge.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xbig.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xlarge.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xbig.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xlarge.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xbig.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xlarge.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xbig.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xlarge.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.headline2(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.big.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.big.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.big.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.big.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.big.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.headline3(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxlarge.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxlarge.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxlarge.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxlarge.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxxlarge.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.large.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.subtitle1(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxlarge.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxlarge.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxlarge.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxlarge.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xxlarge.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.subtitle2(
    BuildContext context, {
    Color? cor,
    double? fontSize,
    bool lineHeigth = false,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xlarge.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xlarge.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xlarge.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xlarge.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xlarge.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.subtitle3(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.large.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.large.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.large.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.large.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.large.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.medium.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.body1(
    BuildContext context, {
    Color? cor,
    double? fontSize,
    bool lineHeigth = false,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.small.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.small.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.small.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.small.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.small.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.body2(
    BuildContext context, {
    Color? cor,
    double? fontSize,
    bool lineHeigth = false,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.medium.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.body3(
    BuildContext context, {
    Color? cor,
    bool lineHeigth = false,
    double? fontSize,
  }) {
    Color textColor = cor ?? corTexto(context);
    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.small.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.small.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.small.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.small.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.small.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xsmall.value : null,
        color: textColor,
      ),
    );
  }
  factory DSTextStyle.caption1(
    BuildContext context, {
    Color? cor,
    double? fontSize,
    bool lineHeigth = false,
  }) {
    Color textColor = cor ?? corTexto(context);

    return DSTextStyle._(
      strong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xsmall.value,
        fontWeight: DSFontWeight.strong.value,
        height: lineHeigth ? DSLineHeigth.xxsmall.value : null,
        color: textColor,
      ),
      defaults: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xsmall.value,
        fontWeight: DSFontWeight.defaults.value,
        height: lineHeigth ? DSLineHeigth.xxsmall.value : null,
        color: textColor,
      ),
      neutral: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xsmall.value,
        fontWeight: DSFontWeight.neutral.value,
        height: lineHeigth ? DSLineHeigth.xxsmall.value : null,
        color: textColor,
      ),
      semiStrong: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xsmall.value,
        fontWeight: DSFontWeight.semiStrong.value,
        height: lineHeigth ? DSLineHeigth.xxsmall.value : null,
        color: textColor,
      ),
      thin: TextStyle(
        package: DSStrings.package,
        fontFamily: DSStrings.fontFamily,
        fontSize: fontSize ?? DSFontSize.xsmall.value,
        fontWeight: DSFontWeight.thin.value,
        height: lineHeigth ? DSLineHeigth.xxsmall.value : null,
        color: textColor,
      ),
    );
  }

  static Color corTexto(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return DSColors.neutralWhite;
    }
    return DSColors.neutralBlack;
  }
}
