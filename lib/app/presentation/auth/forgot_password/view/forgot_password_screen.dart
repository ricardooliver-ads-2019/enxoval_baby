import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_strings.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with ValidationsMixin {
  final _forgotPasswordViewModel = Injection.inject<ForgotPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  Widget get _sizedBoxVerticalDSSpacingBodied =>
      DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.bodied.value);

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      _forgotPasswordViewModel.resetPassword(
        email: _emailController.value.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _forgotPasswordViewModel.addListener(_onResult);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();

    _forgotPasswordViewModel.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DSSpacing.xxbodied.value),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSSizedBoxSpacing.sizedBoxVertical(100),
              Text(
                AuthStrings.esqueceuSuaSenha.text,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              _sizedBoxVerticalDSSpacingBodied,
              Text(
                AuthStrings
                    .informeSeuEmailParaReceberAsInstrucoesDeRedefinicaoDeSenha
                    .text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              _sizedBoxVerticalDSSpacingBodied,
              DSInputTextFormField(
                controller: _emailController,
                focus: _emailFocus,
                label: AppStrings.email.text,
                prefixIcon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              _sizedBoxVerticalDSSpacingBodied,
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                    listenable: _forgotPasswordViewModel,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: _forgotPasswordViewModel.isLoading
                            ? null
                            : _submitEmail,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: DSSpacing.xxsmall.value),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                DSBorderRadius.medium.value),
                          ),
                        ),
                        child: _forgotPasswordViewModel.isLoading
                            ? const CircularProgressIndicator()
                            : Text(AppStrings.continuar.text),
                      );
                    }),
              ),
              _sizedBoxVerticalDSSpacingBodied,
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (_forgotPasswordViewModel.erroMensage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_forgotPasswordViewModel.erroMensage!),
          action: SnackBarAction(
            label: ErrorMessagesEnum.erro.message,
            onPressed: _submitEmail,
          ),
        ),
      );
    }
  }
}
