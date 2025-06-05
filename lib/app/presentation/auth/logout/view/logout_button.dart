import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view_model/logout_view_model.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final logoutViewModel = Injection.inject<LogoutViewModel>();

  @override
  void initState() {
    super.initState();
    logoutViewModel.logout.addListener(_onResult);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: logoutViewModel.logout,
        builder: (context, child) {
          return InkResponse(
            borderRadius: BorderRadius.circular(8.0),
            onTap: logoutViewModel.logout.execute,
            child: const Center(
              child: Icon(
                Icons.logout,
                size: 28,
              ),
            ),
          );
        });
  }

  void _onResult() {
    if (logoutViewModel.logout.completed) {
      logoutViewModel.logout.clearResult();
    }
    if (logoutViewModel.logout.error && logoutViewModel.erroMensage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(logoutViewModel.erroMensage!),
          action: SnackBarAction(
            label: ErrorMessagesEnum.erro.message,
            onPressed: logoutViewModel.logout.execute,
          ),
        ),
      );
    }
  }
}
