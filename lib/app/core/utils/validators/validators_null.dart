class ValidatorsNull {
  /// Verifica se uma String é nula ou vazia
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// Verifica se uma String não é nula e contém conteúdo
  static bool isNotNullAndNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Verifica se uma lista é nula ou vazia
  static bool isNullOrEmptyList(List? value) {
    return value == null || value.isEmpty;
  }
}
