import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kDuration800Mil,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 5.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
