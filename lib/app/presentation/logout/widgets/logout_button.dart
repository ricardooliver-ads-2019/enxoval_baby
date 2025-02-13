import 'package:enxoval_baby/app/core/config/injector/injection.dart';
import 'package:enxoval_baby/app/presentation/logout/viem_model/logout_view_model.dart';
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
    logoutViewModel.addListener(_onResult);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: logoutViewModel,
        builder: (context, child) {
          return InkResponse(
            borderRadius: BorderRadius.circular(8.0),
            onTap: !logoutViewModel.isLoading ? logoutViewModel.logout : () {},
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
    if (logoutViewModel.erroMensage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(logoutViewModel.erroMensage!),
          action: SnackBarAction(
            label: "Erro",
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
