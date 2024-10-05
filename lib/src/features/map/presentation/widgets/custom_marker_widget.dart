import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/utils/enums/map_information.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomMarkerWidget extends StatefulWidget {
  const CustomMarkerWidget({super.key, required this.text});
  final String text;

  @override
  State<CustomMarkerWidget> createState() => _CustomMarkerWidgetState();
}

class _CustomMarkerWidgetState extends State<CustomMarkerWidget> {
  bool shouldFadeText = false;
  bool isWide = true;

  @override
  void initState() {
    isWide = context.read<MapBloc>().state.mapInfo != MapInformation.cosyAreas;
    Future.delayed(kDuration1Sec).then((_) {
      if (mounted) _setTextAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 1200,
      duration: 500,
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        decoration: const BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: BlocConsumer<MapBloc, MapState>(
          listener: (BuildContext context, MapState state) {
            isWide = state.mapInfo != MapInformation.cosyAreas;
            _setTextAnimation();
          },
          builder: (context, state) {
            return AnimatedCrossFade(
              alignment: Alignment.centerLeft,
              duration: kDuration500Mil,
              sizeCurve: Curves.easeOutCubic,
              secondChild: Image.asset(
                AppImages.building,
                color: Colors.white,
                width: 15,
                height: 15,
              ),
              firstChild: AnimatedOpacity(
                duration: kDuration300Mil,
                opacity: shouldFadeText ? 1 : 0,
                child: Text(
                  widget.text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              crossFadeState:
                  isWide ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            );
          },
        ),
      ),
    );
  }

  void _setTextAnimation() {
    shouldFadeText = false;
    if (isWide) {
      Future.delayed(kDuration500Mil).then((_) {
        if (mounted) setState(() => shouldFadeText = true);
      });
    }
  }
}
