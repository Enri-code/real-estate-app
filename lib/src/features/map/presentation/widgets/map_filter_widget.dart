import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class MapFilterWidget extends StatelessWidget {
  const MapFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 100,
      duration: 800,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          AppImages.filter,
          color: Colors.black,
          width: 15.r,
          height: 15.r,
        ),
      ),
    );
  }
}
