enum ErrorMessagesEnum {
  erro('Erro:'),
  erroDesconhecidoAoTentarFazerRegister(
      'Erro desconhecido ao tentar fazer register.'),
  erroDesconhecidoAoTentarFazerLoginGoogle(
      'Erro desconhecido ao tentar fazer loginGoogle.'),
  erroDesconhecidoAoTentarFazerLogin('Erro desconhecido ao tentar login.'),
  erroDesconhecidoAoTentarFazerResetPassword(
      'Erro desconhecido ao tentar fazer logout.'),
  erroDesconhecidoAoTentarFazerLogout(
      'Erro desconhecido ao tentar fazer logout.'),
  erroAoCriarContaDoUsuario('Erro ao criar conta do usuário.'),
  erroAoTentarLoginComContaGoogleUsuarioNaoEncontrado(
      'Erro ao tentar login com conta google. Usuario não encontrado.'),
  erroAoTentarLoginComEmalUsuarioNaoEncontrado(
      'Erro ao tentar login com email. Usuario não encontrado.'),
  ;

  final String message;

  const ErrorMessagesEnum(this.message);
}
