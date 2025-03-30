import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validation_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/register/view_model/register_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_strings.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/utils/routes/home_enxoval_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationsMixin {
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
    _registerViewModel.addListener(_onResult);
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
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DSSpacing.xxbodied.value),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                SizedBox(
                  width: double.infinity,
                  child: ListenableBuilder(
                      listenable: _registerViewModel,
                      builder: (context, child) {
                        return ElevatedButton(
                          onPressed:
                              _registerViewModel.isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: DSSpacing.xxsmall.value),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  DSBorderRadius.medium.value),
                            ),
                          ),
                          child: _registerViewModel.isLoading
                              ? const CircularProgressIndicator()
                              : Text(AuthStrings.cadastrar.text),
                        );
                      }),
                ),
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
      _registerViewModel.register(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );
    }
  }

  void _onResult() {
    if (_registerViewModel.isSuccess) {
      context.go(HomeEnxovalRoutes.homeEnxoval.path);
    }

    if (_registerViewModel.erroMensage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_registerViewModel.erroMensage!),
          action: SnackBarAction(
            label: ErrorMessagesEnum.erro.message,
            onPressed: _submitForm,
          ),
        ),
      );
    }
  }
}
