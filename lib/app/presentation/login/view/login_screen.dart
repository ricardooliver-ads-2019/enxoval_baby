import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/utils/routes/home_enxoval_routes.dart';
import 'package:enxoval_baby/app/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationsMixin {
  final controller = Injection.inject<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onResult);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    controller.removeListener(_onResult);
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      controller.login(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );
    }
  }

  void navigationTo() {
    context.go(HomeEnxovalRoutes.homeEnxoval.path);
  }

  Widget get _sizedBoxVerticalDSSpacingBodied =>
      DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.bodied.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DSSpacing.xxbodied.value),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.xlarge.value),
              const Icon(Icons.person, size: 100, color: Colors.blue),
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.large.value),
              Text(
                AppStrings.bemVindo.text,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              _sizedBoxVerticalDSSpacingBodied,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppStrings.email.text,
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              _sizedBoxVerticalDSSpacingBodied,
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: AppStrings.senha.text,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira sua senha';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.mini.value),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navegar para tela de recuperação de senha
                  },
                  child: Text(AppStrings.esqueceuASenha.text),
                ),
              ),
              _sizedBoxVerticalDSSpacingBodied,
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                    listenable: controller,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: controller.isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: DSSpacing.xxsmall.value),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                DSBorderRadius.medium.value),
                          ),
                        ),
                        child: controller.isLoading
                            ? const CircularProgressIndicator()
                            : Text(AppStrings.entrar.text),
                      );
                    }),
              ),
              _sizedBoxVerticalDSSpacingBodied,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.naoTemUmaConta.text),
                  TextButton(
                    onPressed: () {
                      // Navegar para tela de cadastro
                    },
                    child: Text(AppStrings.criarConta.text),
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
    if (controller.isSuccess) {
      navigationTo();
    }

    if (controller.erroMensage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.erroMensage!),
          action: SnackBarAction(
            label: "Erro",
            onPressed: () => controller.login(
              email: _emailController.value.text,
              password: _passwordController.value.text,
            ),
          ),
        ),
      );
    }
  }
}
