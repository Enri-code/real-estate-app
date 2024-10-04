import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ScaleAnimationWidget(
        delay: 100,
        duration: 500,
        child: Container(
          height: 50.r,
          width: 50.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.3),
          ),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
