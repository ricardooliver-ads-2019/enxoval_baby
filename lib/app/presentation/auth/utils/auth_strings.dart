enum AuthStrings {
  bemVindo('Bem-vindo'),
  bemVindoAoEnxovalBaby('Bem-vindo ao Enxoval Baby'),
  esqueceuASenha('Esqueceu a senha?'),
  naoTemUmaConta('Não tem uma conta?'),
  criarConta('Criar conta'),
  crieUmaSenha('Crie uma nova senha de 6 caracteres'),
  esqueceuSuaSenha('Esqueceu sua senha?'),
  informeSeuEmailParaReceberAsInstrucoesDeRedefinicaoDeSenha(
      'Informe seu email para receber as instruções de redefinição de senha. Enviaremos um link para que você possa criar uma nova senha.'),
  confirmarSenhaObrigatorio('Confirmar Senha*'),
  cadastrar('Cadastrar'),
  prontinhoOEmailParaRedefinirSuaSenhaFoiEnviado(
      'Prontinho! O email para redefinir sua senha foi enviado. Por favor, verifique sua caixa de entrada para seguir as instruções e acessar sua conta novamente.'),
  reenviarEmail('Reenviar e-mail'),
  ;

  final String text;

  const AuthStrings(this.text);
}
