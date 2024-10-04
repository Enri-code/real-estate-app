import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class HomeCountdownWidget extends StatefulWidget {
  const HomeCountdownWidget({
    super.key,
    required this.countDown,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
  });

  final int countDown;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  @override
  State<HomeCountdownWidget> createState() => _HomeCountdownWidgetState();
}

class _HomeCountdownWidgetState extends State<HomeCountdownWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation scaleAnimation;
  late Animation numberAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: kDuration800Mil);

    scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 0.5),
    ]).animate(controller!);
    numberAnimation =
        IntTween(begin: 0, end: widget.countDown).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration800Mil).then(
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
            alignment: Alignment.center,
            child: Container(
              height: 170.r,
              width: 170.r,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.2),
                    blurRadius: 50,
                  )
                ],
              ),
              child: Column(
                children: [
                  10.verticalSpace,
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: widget.textColor,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    numberAnimation.value.toString(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: widget.textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
