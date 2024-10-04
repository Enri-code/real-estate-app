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
      duration: kDuration1Sec,
    );

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration500Mil).then(
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
    return AnimatedBuilder(
      animation: scaleAnimation,
      child: Container(
        width: 50.r,
        height: 50.r,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/profile.png'),
          ),
        ),
      ),
      builder: (context, child) {
        return Transform.scale(scale: scaleAnimation.value, child: child);
      },
    );
  }
}
