import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/utils/enums/map_information.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 1200,
      duration: 500,
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            bool isWide = state.mapInfo != MapInformation.cosyAreas;
            return AnimatedCrossFade(
              alignment: Alignment.centerLeft,
              duration: kDuration500Mil,
              sizeCurve: Curves.easeOutCubic,
              firstChild: Image.asset(
                AppImages.building,
                color: Colors.white,
                width: 15.r,
                height: 15.r,
              ),
              secondChild: Text(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
              crossFadeState: !isWide
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            );
          },
        ),
      ),
    );
  }
}
