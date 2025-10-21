import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/onboarding_layette_customization_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyLayettesWidget extends StatelessWidget {
  const EmptyLayettesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagePaths.mommyWondering.path,
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'Você ainda não tem nenhum enxoval',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Clique no botão abaixo para criar seu primeiro enxoval',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.push(OnboardingLayetteCustomizationRoutes
                  .onboardingLayetteCustomizationPageView.path);
            },
            icon: const Icon(Icons.add),
            label: const Text('Criar Enxoval'),
          ),
        ],
      ),
    );
  }
}
