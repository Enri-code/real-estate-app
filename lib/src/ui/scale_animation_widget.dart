import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  const ScaleAnimationWidget({
    super.key,
    this.delay,
    required this.duration,
    required this.child,
    this.curve = Curves.easeOut,
    this.alignment = Alignment.center,
  });

  /// initial delay in milliseconds
  final int? delay;

  /// duration of animation in milliseconds
  final int duration;

  /// animation curve
  final Curve curve;

  final AlignmentGeometry alignment;

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

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller!, curve: widget.curve),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.delay != null) {
        await Future.delayed(Duration(milliseconds: widget.delay!));
      }
      if (controller != null) controller?.forward();
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
          alignment: widget.alignment,
          child: widget.child,
        );
      },
    );
  }
}
