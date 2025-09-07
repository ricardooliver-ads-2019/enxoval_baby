import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/command/command_handler_mixin.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/validation_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/register/view_model/register_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_strings.dart';
import 'package:enxoval_baby/app/core/widgets/action_buttom_widget.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/widgets/welcome_illustration_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationsMixin, CommandHandlerMixin {
  final _registerViewModel = Injection.inject<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordController = TextEditingController();
  final _confirmPasswordFocus = FocusNode();

  Widget get _sizedBoxVerticalDSSpacingBodied =>
      DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.bodied.value);

  @override
  void initState() {
    super.initState();
    handleCommand(_registerViewModel.register, retry: _submitForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DSSpacing.xxbodied.value),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WelcomeIllustrationWidget(),
                DSInputTextFormField(
                  controller: _emailController,
                  focus: _emailFocus,
                  label: AppStrings.emailObrigatorio.text,
                  prefixIcon: const Icon(Icons.email),
                  textInputType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                _sizedBoxVerticalDSSpacingBodied,
                DSInputPassword(
                  controller: _passwordController,
                  focus: _passwordFocus,
                  label: AppStrings.senhaObrigatorio.text,
                  prefixIcon: const Icon(Icons.lock),
                  validator: passwordValidator,
                ),
                _sizedBoxVerticalDSSpacingBodied,
                DSInputPassword(
                  controller: _confirmPasswordController,
                  focus: _confirmPasswordFocus,
                  label: AuthStrings.confirmarSenhaObrigatorio.text,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (String? valor) {
                    if (valor!.isEmpty) {
                      return ValidationMessagesEnum.campoObrigatorio.text;
                    }
                    if (valor != _passwordController.text) {
                      return ValidationMessagesEnum.senhasNaoEstaoIguais.text;
                    }
                    return null;
                  },
                ),
                DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.xxbodied.value),
                ListenableBuilder(
                    listenable: _registerViewModel.register,
                    builder: (context, child) {
                      return ActionButtonWidget(
                        isLoading: _registerViewModel.register.running,
                        text: AppStrings.entrar.text,
                        onPressed: _submitForm,
                      );
                    }),
                _sizedBoxVerticalDSSpacingBodied,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _registerViewModel.register.execute((
        _emailController.value.text,
        _passwordController.value.text,
      ));
    }
  }

}
