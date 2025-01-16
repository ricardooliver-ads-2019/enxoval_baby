enum DSFontSize {
  /// tamanho de 12.0px
  xsmall(12.0),

  /// tamanho de 14.0px
  small(14.0),

  /// tamanho de 16.0px
  defaults(16.0),

  /// tamanho de 18.0px
  medium(18.0),

  /// tamanho de 20.0px
  large(20.0),

  /// tamanho de 24.0px
  xlarge(24.0),

  /// tamanho de 28.0px
  xxlarge(28.0),

  /// tamanho de 32.0px
  xxxlarge(32.0),

  /// tamanho de 36.0px
  big(36.0),

  /// tamanho de 40.0px
  xbig(40.0),

  ///tamanho de 48.0px
  xxbig(48.0),

  /// tamanho de 56.0px
  xxxbig(56.0),
  ;

  final double value;

  const DSFontSize(this.value);
}
