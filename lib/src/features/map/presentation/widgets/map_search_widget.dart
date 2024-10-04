import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class MapSearchWidget extends StatelessWidget {
  const MapSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 1800,
      duration: 500,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              height: 45.h,
              width: 45.h,
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.search,
                color: Colors.black,
                width: 15.r,
                height: 15.r,
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  isDense: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
