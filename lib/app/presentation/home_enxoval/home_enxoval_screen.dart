import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/core/command/command_handler_mixin.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view/logout_button.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/widgets/card_layette_widget.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/view_model/home_enxoval_view_model.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/widgets/empty_layettes_widget.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/onboarding_layette_customization_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeEnxovalScreen extends StatefulWidget {
  const HomeEnxovalScreen({super.key});

  @override
  State<HomeEnxovalScreen> createState() => _HomeEnxovalScreenState();
}

class _HomeEnxovalScreenState extends State<HomeEnxovalScreen>
    with CommandHandlerMixin {
  final _viewModel = Injection.inject<HomeEnxovalViewModel>();

  @override
  void initState() {
    super.initState();
    handleCommand(
      _viewModel.getUserLayettes,
      onError: (error) {
        // TODO: Handle error state
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getUserLayettes.execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Enxovais'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: LogoutButton(),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel.getUserLayettes,
        builder: (context, child) {
          final layettesResult = _viewModel.getUserLayettes;
          if (layettesResult.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (layettesResult.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ocorreu um erro ao carregar seus enxovais',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _viewModel.getUserLayettes.execute(),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (layettesResult.completed) {
            if (_viewModel.layettes.isEmpty) {
              return const EmptyLayettesWidget();
            }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _viewModel.layettes.length,
                itemBuilder: (context, index) {
                  final layette = _viewModel.layettes[index];
                  return CardLayetteWidget(
                    layette: layette,
                    onTap: () {
                      // TODO: Navigate to layette details
                    },
                  );
                },
              );
          }

          return const EmptyLayettesWidget();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(OnboardingLayetteCustomizationRoutes
              .onboardingLayetteCustomizationPageView.path);
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Enxoval'),
      ),
    );
  }
}
