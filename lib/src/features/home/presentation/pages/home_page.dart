import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/buy_amount_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_listing_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/location_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/rent_amount_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/user_profile_widget.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? homeAnimontroller;
  late Animation slideAnimation;

  @override
  void initState() {
    super.initState();
    homeAnimontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    slideAnimation = Tween(begin: 0.0, end: 1.0).animate(homeAnimontroller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1800)).then((_) async {
        if (homeAnimontroller != null) {
          await homeAnimontroller?.forward();

          /// checks for null controller
          /// avoid calling the animation if widget has been disposed
          slideAnimation =
              Tween(begin: 1.0, end: 0.6).animate(homeAnimontroller!);
          homeAnimontroller!.reset();
        }
      });
    });
  }

  @override
  void dispose() {
    homeAnimontroller?.dispose();
    homeAnimontroller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f8f8),
      body: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) {
          if ((details.primaryVelocity ?? 0) > 0) {
            swipeUp();
          } else if ((details.primaryVelocity ?? 0) < 0) {
            swipeDown();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocationWidget(),
                          UserProfileWidget(),
                        ],
                      ),
                    ),

                    50.verticalSpace,
                    // AnimatedTextKit(
                    //   animatedTexts: [
                    //     FadeAnimatedText(
                    //       'Fade First',
                    //       textStyle: TextStyle(
                    //           fontSize: 32.0, fontWeight: FontWeight.bold),
                    //     ),
                    //     ScaleAnimatedText(
                    //       'Then Scale',
                    //       textStyle: TextStyle(
                    //           fontSize: 70.0, fontFamily: 'Canterbury'),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuyAmountWidget(
                            amount: 982,
                          ),
                          RentAmountWidget(
                            amount: 1200,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // HomeListingWidget(),
            AnimatedBuilder(
              animation: slideAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 0.85.sh * slideAnimation.value,
                    ),
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.2),
                          blurRadius: 50,
                        )
                      ],
                    ),
                    child: const HomeListingWidget(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void swipeDown() async {
    if (homeAnimontroller?.isCompleted ?? false) {
      await homeAnimontroller!.reverse();
    }
  }

  void swipeUp() {
    homeAnimontroller?.forward();
  }
}
