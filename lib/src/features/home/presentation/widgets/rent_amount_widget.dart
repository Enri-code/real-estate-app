import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class RentAmountWidget extends StatefulWidget {
  final int amount;
  const RentAmountWidget({
    super.key,
    required this.amount,
  });

  @override
  State<RentAmountWidget> createState() => _RentAmountWidgetState();
}

class _RentAmountWidgetState extends State<RentAmountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<int> numberAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 0.5),
    ]).animate(controller);
    numberAnimation =
        IntTween(begin: 0, end: widget.amount).animate(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 800),
      ).then(
        (_) {
          controller.forward();
        },
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
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
                    "RENT",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFa6957e),
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    numberAnimation.value.toString(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFa6957e),
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    "offers",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFa6957e),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
