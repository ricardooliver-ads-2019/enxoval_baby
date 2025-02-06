enum ValidationMessagesEnum {
  campoObrigatorio('Campo obrigatório'),
  porfavorInsiraSeuEmail('Por favor insira seu email'),
  porFavorInformeUmEmailValido('Por favor informe um email válido'),
  porFavorInformeUmNomeCompleto('Por favor informe um nome completo'),
  porFavorInformeNomeValido('Por favor informe um nome Valido'),
  porFavorPreenchaComAInformacaoSolicitada(
      'Por favor preencha com a informação solicitada'),
  ;

  final String text;
  const ValidationMessagesEnum(this.text);
}
