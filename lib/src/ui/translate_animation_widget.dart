import 'package:flutter/material.dart';

class TranslateAnimationWidget extends StatefulWidget {
  const TranslateAnimationWidget({
    super.key,
    required this.delay,
    required this.duration,
    required this.child,
    this.curve = Curves.easeInQuad,
    required this.offset,
  });

  /// initial delay in milliseconds
  final int delay;

  /// duration of animation in milliseconds
  final int duration;

  /// animation curve
  final Curve curve;

  /// final initial offset of animation
  final Offset offset;

  /// child widget
  final Widget child;

  @override
  State<TranslateAnimationWidget> createState() =>
      _TranslateAnimationWidgetState();
}

class _TranslateAnimationWidgetState extends State<TranslateAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    offsetAnimation = Tween<Offset>(
      begin: widget.offset,
      end: const Offset(0, 0),
    ).animate(controller!);

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
        animation: offsetAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: offsetAnimation.value,
            child: widget.child,
          );
        });
  }
}
