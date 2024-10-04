import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class BuyAmountWidget extends StatefulWidget {
  final int amount;
  const BuyAmountWidget({
    super.key,
    required this.amount,
  });

  @override
  State<BuyAmountWidget> createState() => _BuyAmountWidgetState();
}

class _BuyAmountWidgetState extends State<BuyAmountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation scaleAnimation;
  late Animation numberAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: kDuration800Mil);

    scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 0.5),
    ]).animate(controller!);
    numberAnimation =
        IntTween(begin: 0, end: widget.amount).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration800Mil).then(
        (_) {
          if (controller != null) {
            controller?.forward();
          }
        },
      );
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
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnimation.value,
            alignment: Alignment.center,
            child: Container(
              height: 170.r,
              width: 170.r,
              decoration: BoxDecoration(
                color: AppColor.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.2),
                    blurRadius: 50,
                  )
                ],
              ),
              child: Column(
                children: [
                  10.verticalSpace,
                  Text(
                    "BUY",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    numberAnimation.value.toString(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    "offers",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
