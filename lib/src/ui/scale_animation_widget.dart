import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  const ScaleAnimationWidget({
    super.key,
    required this.delay,
    required this.duration,
    required this.child,
    this.curve = Curves.easeInQuad,
  });

  /// initial delay in milliseconds
  final int delay;

  /// duration of animation in milliseconds
  final int duration;

  /// animation curve
  final Curve curve;

  /// child widget
  final Widget child;

  @override
  State<ScaleAnimationWidget> createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.delay)).then(
        (_) {
          if (controller != null) {
            controller?.forward();
          }
        },
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnimation.value,
            child: widget.child,
          );
        });
  }
}
