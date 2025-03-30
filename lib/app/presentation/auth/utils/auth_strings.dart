enum AuthStrings {
  bemVindo('Bem-vindo'),
  esqueceuASenha('Esqueceu a senha?'),
  naoTemUmaConta('Não tem uma conta?'),
  criarConta('Criar conta'),
  crieUmaSenha('Crie uma nova senha de 6 caracteres'),
  esqueceuSuaSenha('Esqueceu sua senha?'),
  informeSeuEmailParaReceberAsInstrucoesDeRedefinicaoDeSenha(
      'Informe seu email para receber as instruções de redefinição de senha. Enviaremos um link para que você possa criar uma nova senha.'),
  confirmarSenhaObrigatorio('Confirmar Senha*'),
  cadastrar('Cadastrar'),
  ;

  final String text;

  const AuthStrings(this.text);
}
