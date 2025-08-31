import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validation_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_routes.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_strings.dart';
import 'package:enxoval_baby/app/core/widgets/action_buttom_widget.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/widgets/welcome_illustration_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationsMixin {
  final _loginViewModel = Injection.inject<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loginViewModel.login.addListener(_onResult);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    _loginViewModel.removeListener(_onResult);
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      _loginViewModel.login.execute((
        _emailController.value.text,
        _passwordController.value.text,
      ));
    }
  }

  Widget get _sizedBoxVerticalDSSpacingBodied =>
      DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.bodied.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: DSSpacing.xxxlarge.value,
          right: DSSpacing.xxbodied.value,
          left: DSSpacing.xxbodied.value,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const WelcomeIllustrationWidget(),
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.mini.value),
              DSInputTextFormField(
                controller: _emailController,
                focus: _emailFocus,
                label: AppStrings.email.text,
                prefixIcon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              _sizedBoxVerticalDSSpacingBodied,
              DSInputPassword(
                controller: _passwordController,
                focus: _passwordFocus,
                label: AppStrings.senha.text,
                prefixIcon: const Icon(Icons.lock),
                validator: (text) => genericValidator(
                  text,
                  6,
                  ValidationMessagesEnum.senhaInvalida.text,
                ),
              ),
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.quarck.value),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.push(AuthRoutes.forgotPassword.path);
                  },
                  child: Text(AuthStrings.esqueceuASenha.text),
                ),
              ),
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.mini.value),
              ListenableBuilder(
                  listenable: _loginViewModel.login,
                  builder: (context, child) {
                    return ActionButtonWidget(
                      isLoading: _loginViewModel.login.running,
                      text: AppStrings.entrar.text,
                      onPressed: _submitLogin,
                    );
                  }),
              _sizedBoxVerticalDSSpacingBodied,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AuthStrings.naoTemUmaConta.text),
                  TextButton(
                    onPressed: () {
                      context.push(AuthRoutes.register.path);
                    },
                    child: Text(AuthStrings.criarConta.text),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (_loginViewModel.login.completed) {
      _loginViewModel.login.clearResult();
    }
    if (_loginViewModel.erroMensage != null && _loginViewModel.login.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_loginViewModel.erroMensage!),
          action: SnackBarAction(
            label: ErrorMessagesEnum.erro.message,
            onPressed: _submitLogin,
          ),
        ),
      );
    }
  }
}
