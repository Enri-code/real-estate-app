import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget>
    with SingleTickerProviderStateMixin {
  bool animateSize = false;
  bool animateOpacity = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(kDuration300Mil);
      if (!mounted) return;
      setState(() => animateSize = true);
      await Future.delayed(kDuration1Sec);
      if (!mounted) return;
      setState(() => animateOpacity = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50.h,
      curve: Curves.easeInOut,
      duration: kDuration1_8Sec,
      constraints: BoxConstraints(maxWidth: animateSize ? 0.5.sw : 0),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: AnimatedOpacity(
        opacity: animateOpacity ? 1 : 0,
        duration: kDuration500Mil,
        curve: Curves.easeInOutSine,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            2.horizontalSpace,
            Icon(
              Icons.location_on_rounded,
              size: 16.sp,
              color: AppColor.grey,
            ),
            3.horizontalSpace,
            Flexible(
              child: Text(
                "Saint Petersburg",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            6.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
