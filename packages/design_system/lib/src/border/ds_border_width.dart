enum DSBorderWidth {
  /// Width de 0.0px
  none(0.0),

  /// Width de 1.0px
  hairline(1.0),

  /// Width de 2.0px
  thin(2.0),

  /// Width de 4.0px
  thicky(4.0),

  /// Width de 8.0px
  heavy(8.0),
  ;

  const DSBorderWidth(this.value);

  final double value;
}
