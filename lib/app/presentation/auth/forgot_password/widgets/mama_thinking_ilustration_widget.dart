import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:flutter/material.dart';

class MamaThinkingIlustrationWidget extends StatelessWidget {
  const MamaThinkingIlustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImagePaths.mamaThinking.path,
        fit: BoxFit.cover,
        height: MediaQuery.sizeOf(context).height * 0.25,
      ),
    );
  }
}
