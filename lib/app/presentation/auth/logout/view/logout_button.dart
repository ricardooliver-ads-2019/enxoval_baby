import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/command/command_handler_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view_model/logout_view_model.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> with CommandHandlerMixin {
  final logoutViewModel = Injection.inject<LogoutViewModel>();

  @override
  void initState() {
    super.initState();
    handleCommand(logoutViewModel.logout, retry: logoutViewModel.logout.execute);
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
}
