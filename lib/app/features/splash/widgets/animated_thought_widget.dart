import 'package:enxoval_baby/app/utils/image_paths.dart';
import 'package:flutter/material.dart';

class AnimatedThoughtWidget extends StatefulWidget {
  final VoidCallback whenTheAnimationEnds;
  final double height;
  const AnimatedThoughtWidget({
    super.key,
    required this.height,
    required this.whenTheAnimationEnds,
  });

  @override
  State<AnimatedThoughtWidget> createState() => _AnimatedThoughtWidgetState();
}

class _AnimatedThoughtWidgetState extends State<AnimatedThoughtWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _imageIndexAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    /// Animação para trocar o índice da imagem
    _imageIndexAnimation =
        IntTween(begin: 0, end: ImageThoughtPaths.values.length - 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _imageIndexAnimation.addListener(() {
      _currentIndex = _imageIndexAnimation.value;
    });

    _controller.forward();

    _controller.addStatusListener(whenTheAnimationEnds);
  }

  void whenTheAnimationEnds(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.whenTheAnimationEnds();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(ImageThoughtPaths.values.length, (index) {
        final imagePath = ImageThoughtPaths.values[index].path;
        return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return AnimatedOpacity(
                opacity: _currentIndex == index ? 1.0 : 0,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1000),
                child: Image.asset(
                  imagePath,
                  height: widget.height,
                ),
              );
            });
      }),
    );
  }
}
