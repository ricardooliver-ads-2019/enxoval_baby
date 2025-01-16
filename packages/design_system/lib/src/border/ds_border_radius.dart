enum DSBorderRadius {
  /// Radius de 0.0px
  none(0.0),

  /// Radius de 2.0px
  minimal(2.0),

  /// Radius de 4.0px
  light(4.0),

  /// Radius de 8.0px
  defaults(8.0),

  /// Radius de 10.0px
  medium(10.0),

  /// Radius de 20.0px
  large(20.0),

  /// Radius de 96.0px
  circular(96.0),
  ;

  const DSBorderRadius(this.value);
  final double value;
}
