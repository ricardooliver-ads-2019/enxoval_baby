enum ClimateEnum {
  quente,
  frio,
  tropical;

  static ClimateEnum fromString(String value) {
    return ClimateEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ClimateEnum.tropical,
    );
  }

  String toCode() {
    switch (this) {
      case ClimateEnum.quente:
        return 'hot';
      case ClimateEnum.frio:
        return 'cold';
      case ClimateEnum.tropical:
        return 'tropical';
    }
  }
}


