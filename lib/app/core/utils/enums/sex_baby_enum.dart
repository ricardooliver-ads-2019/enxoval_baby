enum SexBabyEnum {
  masculino,
  feminino,
  indefinido;

  static SexBabyEnum fromString(String value) {
    return SexBabyEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SexBabyEnum.indefinido,
    );
  }
}
