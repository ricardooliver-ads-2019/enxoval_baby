enum ErrorMessagesEnum {
  erro('Erro:'),
  erroDesconhecido('Erro desconhecido.'),
  erroDesconhecidoAoTentarFazerRegister('Erro desconhecido ao tentar fazer register.'),
  erroDesconhecidoAoTentarFazerLoginGoogle('Erro desconhecido ao tentar fazer loginGoogle.'),
  erroDesconhecidoAoTentarFazerLogin('Erro desconhecido ao tentar login.'),
  erroDesconhecidoAoTentarFazerResetPassword('Erro desconhecido ao tentar fazer resetPassword.'),
  erroDesconhecidoAoTentarFazerLogout('Erro desconhecido ao tentar fazer logout.'),
  erroAoCriarContaDoUsuario('Erro ao criar conta do usuário.'),
  erroAoTentarLoginComContaGoogleUsuarioNaoEncontrado('Erro ao tentar login com conta google. Usuario não encontrado.'),
  erroAoTentarLoginComEmailUsuarioNaoEncontrado('Erro ao tentar login com email. Usuario não encontrado.'),
  erroAoBuscarDadosDoUsuario('Erro ao buscar dados do usuário.'),
  ;

  final String message;

  const ErrorMessagesEnum(this.message);
}
