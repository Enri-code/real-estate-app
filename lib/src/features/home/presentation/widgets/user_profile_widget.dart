import 'package:flutter/material.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 300,
      duration: 800,
      curve: Curves.easeOutCubic,
      child: Container(
        height: 48,
        width: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage(AppImages.profile)),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
