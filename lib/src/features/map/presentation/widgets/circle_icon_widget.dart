import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({
    super.key,
    required this.icon,
    this.onTap,
  });

  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ScaleAnimationWidget(
        delay: 1800,
        duration: 500,
        child: Container(
          height: 50.r,
          width: 50.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.3),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            icon,
            color: Colors.white,
            width: 15.r,
            height: 15.r,
          ),
        ),
      ),
    );
  }
}
