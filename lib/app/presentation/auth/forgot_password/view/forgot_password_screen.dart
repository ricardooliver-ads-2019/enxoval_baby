import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/command/command_handler_mixin.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/forgot_password/widgets/mama_thinking_ilustration_widget.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_strings.dart';
import 'package:enxoval_baby/app/core/widgets/action_buttom_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with ValidationsMixin, CommandHandlerMixin {
  final _forgotPasswordViewModel = Injection.inject<ForgotPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  Widget get _sizedBoxVerticalDSSpacingBodied =>
      DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.bodied.value);

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      _forgotPasswordViewModel.resetPassword.execute(
        _emailController.value.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _forgotPasswordViewModel.resetPassword.addListener(_onResult);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: ListenableBuilder(
          listenable: _forgotPasswordViewModel.resetPassword,
          builder: (context, child) {
            return SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: DSSpacing.xxbodied.value),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MamaThinkingIlustrationWidget(),
                    _forgotPasswordViewModel.resetPassword.completed
                        ? Text(
                            AuthStrings
                                .prontinhoOEmailParaRedefinirSuaSenhaFoiEnviado
                                .text,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AuthStrings.esqueceuSuaSenha.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              DSSizedBoxSpacing.sizedBoxVertical(
                                  DSSpacing.quarck.value),
                              Text(
                                AuthStrings
                                    .informeSeuEmailParaReceberAsInstrucoesDeRedefinicaoDeSenha
                                    .text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
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
                    ActionButtonWidget(
                      isLoading: _forgotPasswordViewModel.resetPassword.running,
                      text: _forgotPasswordViewModel.resetPassword.completed
                          ? AuthStrings.reenviarEmail.text
                          : AppStrings.continuar.text,
                      onPressed: _submitEmail,
                    ),
                    _sizedBoxVerticalDSSpacingBodied,
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onResult() {
    if (_forgotPasswordViewModel.erroMensage != null &&
        _forgotPasswordViewModel.resetPassword.error) {
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
