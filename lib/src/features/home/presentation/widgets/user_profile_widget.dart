import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: kDuration800Mil,
    );

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(controller!);

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
              height: 50.r,
              width: 50.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          );
        });
  }
}
