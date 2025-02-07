import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/features/login/utils/login_routes.dart';
import 'package:enxoval_baby/app/features/splash/widgets/animated_thought_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationTo() {
    context.go(LoginRoutes.login.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      ImagePaths.thought.path,
                      fit: BoxFit.cover,
                      height: constraints.maxHeight * 0.2,
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: constraints.maxHeight * .033),
                        child: AnimatedThoughtWidget(
                          height: constraints.maxHeight * .1,
                          whenTheAnimationEnds: navigationTo,
                        )),
                  )
                ],
              ),
            ),
            Center(
              child: Image.asset(
                ImagePaths.pregnant.path,
                fit: BoxFit.cover,
                height: constraints.maxHeight * 0.6,
              ),
            ),
          ],
        );
      }),
    );
  }
}
