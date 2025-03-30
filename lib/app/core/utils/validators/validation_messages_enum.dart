enum ValidationMessagesEnum {
  campoObrigatorio('Campo obrigatório'),
  porfavorInsiraSeuEmail('Por favor insira seu email'),
  porFavorInformeUmEmailValido('Por favor informe um email válido'),
  porFavorInformeUmNomeCompleto('Por favor informe um nome completo'),
  porFavorInformeNomeValido('Por favor informe um nome Valido'),
  porFavorPreenchaComAInformacaoSolicitada(
      'Por favor preencha com a informação solicitada'),
  senhasNaoEstaoIguais('Senhas não estão iguais'),
  aSenhaDeveTerNoMinimo6Caracteres('A senha deve ter no mínimo 6 caracteres.'),
  aSenhaDeveConterNumero('A senha deve conter número.'),
  aSenhaDeveConterPeloMenosUmaLentraMinuscula(
      'A senha deve conter pelo menos uma letra minúscula.'),
  aSenhaDeveConterPeloMenosUmCaracterEspecial(
      'A senha deve conter pelo menos um caracter especial.'),
  aSenhaDeveConterPeloMenosUmaLentraMaiuscula(
      'A senha deve conter pelo menos uma letra maiúscula.'),
  aSenhaDeveTerPeloMenos(
      'A senha deve ter: No mínimo 6 caracteres.\nPelo menos dois ou mais números.\nletras minúsculas e maiúsculas.'),
  senhaCaracteres('8 a 16 caracteres'),
  ;

  final String text;
  const ValidationMessagesEnum(this.text);
}
