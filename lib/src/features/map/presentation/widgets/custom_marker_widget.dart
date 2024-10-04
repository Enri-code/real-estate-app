import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/enums/map_information.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 1800,
      duration: 300,
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          bool isWide = state.mapInfo == MapInformation.cosyAreas;
          return AnimatedContainer(
            duration: kDuration500Mil,
            height: 40.h,
            width: isWide ? 40.w : 100.w,
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
            child: Builder(builder: (context) {
              if (isWide) {
                return const Icon(
                  Icons.business,
                  color: Colors.white,
                );
              }

              return Text(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
