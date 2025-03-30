enum AppStrings {
  bemVindo('Bem-vindo'),
  email('Email'),
  senha('Senha'),
  esqueceuASenha('Esqueceu a senha?'),
  entrar('Entrar'),
  naoTemUmaConta('Não tem uma conta?'),
  criarConta('Criar conta'),
  crieUmaSenha('Cria uma nova senha de 8 caracteres'),
  nomeCompletoObrigatorio('Nome completo*'),
  emailObrigatorio('Email*'),
  telefoneObrigatorio('Telefone*'),
  senhaObrigatorio('Senha*'),
  confirmarSenhaObrigatorio('Confirmar Senha*'),
  cadastrar('Cadastrar'),
  esqueceuSuaSenha('Esqueceu sua senha?'),
  continuar('Continuar'),
  informeSeuEmailParaReceberAsInstrucoesDeRedefinicaoDeSenha(
      'Informe seu email para receber as instruções de redefinição de senha. Enviaremos um link para que você possa criar uma nova senha.'),
  ;

  final String text;

  const AppStrings(this.text);
}
