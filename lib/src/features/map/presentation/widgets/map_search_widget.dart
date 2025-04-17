import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/core/constants/app_images.dart';
import 'package:real_estate_app/src/core/widgets/scale_animation_widget.dart';

class MapSearchWidget extends StatefulWidget {
  const MapSearchWidget({super.key});

  @override
  State<MapSearchWidget> createState() => _MapSearchWidgetState();
}

class _MapSearchWidgetState extends State<MapSearchWidget> {
  final inputController = TextEditingController();

  @override
  void initState() {
    inputController.text = 'Saint Petersburg';
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 100,
      duration: 800,
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
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
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
