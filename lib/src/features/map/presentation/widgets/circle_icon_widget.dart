import 'package:flutter/material.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({super.key, required this.icon, this.onTap});

  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ScaleAnimationWidget(
        delay: 100,
        duration: 800,
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.25),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            icon,
            color: Colors.white,
            width: 15,
            height: 15,
          ),
        ),
      ),
    );
  }
}
