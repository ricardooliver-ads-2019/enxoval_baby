class DSStrings {
  static final DSStrings _instance = DSStrings._internal();

  factory DSStrings() {
    return _instance;
  }

  DSStrings._internal();

  static const String package = 'design_system';
  static String fontFamily = 'outfit';

  static void setFontFamily({String? font}) {
    if (font != null) fontFamily = font;
  }
}
