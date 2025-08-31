enum ExpectedBabySizeEnum {
  pequeno,
  normal,
  grande,
  extraGrande;

  static ExpectedBabySizeEnum fromString(String value) {
    return ExpectedBabySizeEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ExpectedBabySizeEnum.normal,
    );
  }
}
