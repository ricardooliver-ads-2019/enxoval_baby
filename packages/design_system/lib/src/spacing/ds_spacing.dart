enum DSSpacing {
  /// Espacamento de 0.0px
  none(0.0),

  /// Espacamento de 2.0px
  nano(2.0),

  /// Espacamento de 4.0px
  quarck(4.0),

  /// Espacamento de 8.0px
  micro(8.0),

  /// Espacamento de 10.0px
  mini(10.0),

  /// Espacamento de 12.0px
  xxxsmall(12.0),

  /// Espacamento de 14.0px
  xxsmall(14.0),

  /// Espacamento de 16.0px
  xsmall(16.0),

  /// Espacamento de 18.0px
  smal(18.0),

  /// Espacamento de 20.0px
  bodied(20.0),

  /// Espacamento de 22.0px
  xbodied(22.0),

  /// Espacamento de 24.0px
  xxbodied(24.0),

  /// Espacamento de 28.0px
  xxxbodied(28.0),

  /// Espacamento de 32.0px
  large(32.0),

  /// Espacamento de 40.0px
  xlarge(40.0),

  /// Espacamento de 48.0px
  xxlarge(48.0),

  /// Espacamento de 56.0px
  xxxlarge(56.0),

  /// Espacamento de 64.0px
  big(64.0),

  /// Espacamento de 72.0px
  xbig(72.0),

  /// Espacamento de 80.0px
  xxbig(80.0),

  /// Espacamento de 88.0px
  xxxbig(88.0),

  /// Espacamento de 96.0px
  giant(96.0),
  ;

  const DSSpacing(this.value);

  final double value;
}
