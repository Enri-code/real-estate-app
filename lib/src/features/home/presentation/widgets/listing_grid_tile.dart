import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class ListingGridTile extends StatefulWidget {
  const ListingGridTile({
    super.key,
    required this.widthRatio,
    required this.heightRatio,
    required this.listing,
  });

  final int widthRatio;
  final int heightRatio;
  final HomeListing listing;

  @override
  State<ListingGridTile> createState() => _ListingGridTileState();
}

class _ListingGridTileState extends State<ListingGridTile>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation expandWidthAnimation;
  late Animation expandHeightAnimation;
  late Animation fadeAnimation;
  late double maxSlideWidth;
  late double circleWidth;

  @override
  void initState() {
    super.initState();
    maxSlideWidth = 345.w * (widget.widthRatio / 4);
    circleWidth = 50.r;

    controller = AnimationController(vsync: this, duration: kDuration800Mil);

    expandWidthAnimation =
        Tween(begin: circleWidth, end: maxSlideWidth).animate(
      CurvedAnimation(parent: controller!, curve: Curves.easeIn),
    );
    expandWidthAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: circleWidth), weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: circleWidth, end: maxSlideWidth), weight: 70),
    ]).animate(
      controller!,
    );

    expandHeightAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: circleWidth), weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: circleWidth, end: circleWidth), weight: 70),
    ]).animate(
      controller!,
    );

    fadeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 90),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
    ]).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        if (controller != null) {
          controller!.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (context, child) {
          return Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.blue.withOpacity(0.1),
                image: DecorationImage(
                  image: AssetImage(widget.listing.image),
                  fit: BoxFit.cover,
                )),
            child: SizedBox(
              height: expandHeightAnimation.value,
              width: expandWidthAnimation.value,
              child: Blur(
                blur: 2.5,
                blurColor: AppColor.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(40.r),
                overlay: Padding(
                  padding: EdgeInsets.all(5.r),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: fadeAnimation.value,
                          child: Text(
                            widget.listing.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 40.r,
                          height: 40.r,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppColor.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: const SizedBox(),
              ),
            ),
          );
        });
  }
}
