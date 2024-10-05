import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class HomeCountdownWidget extends StatefulWidget {
  const HomeCountdownWidget({
    super.key,
    required this.countDown,
    required this.title,
    required this.textColor,
    required this.decoration,
  });

  final int countDown;
  final String title;
  final Color textColor;
  final BoxDecoration decoration;

  @override
  State<HomeCountdownWidget> createState() => _HomeCountdownWidgetState();
}

class _HomeCountdownWidgetState extends State<HomeCountdownWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation numberAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    numberAnimation = IntTween(
      begin: 0,
      end: widget.countDown,
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeOutQuad));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration2Sec).then(
        (_) {
          if (controller != null) controller?.forward();
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
    return ScaleAnimationWidget(
      delay: 2300,
      duration: 1400,
      curve: Curves.easeInOutCubic,
      child: DecoratedBox(
        decoration: widget.decoration,
        child: Column(
          children: [
            16.verticalSpace,
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: widget.textColor,
              ),
            ),
            20.verticalSpace,
            AnimatedBuilder(
              animation: numberAnimation,
              builder: (context, child) {
                return Text(
                  numberAnimation.value.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: widget.textColor,
                  ),
                );
              },
            ),
            Text(
              'offers',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: widget.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
