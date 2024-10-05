import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_countdown_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_listing_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/location_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/user_profile_widget.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey<ScaffoldState>();
  AnimationController? titleAnimationController;
  late Animation<Offset> textSlideAnimation;

  @override
  void initState() {
    super.initState();
    titleAnimationController = AnimationController(
      vsync: this,
      duration: kDuration800Mil,
    );

    textSlideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 1),
        ),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
        weight: 0.8,
      ),
    ]).animate(CurvedAnimation(
      parent: titleAnimationController!,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration1_8Sec).then((_) {
        return titleAnimationController?.forward();
      });
      Future.delayed(const Duration(milliseconds: 4000)).then((_) {
        key.currentState?.showBottomSheet(
          backgroundColor: Colors.transparent,
          sheetAnimationStyle: AnimationStyle(
            duration: kDuration800Mil,
            curve: Curves.decelerate,
          ),
          (context) {
            return DraggableScrollableSheet(
              snap: true,
              expand: false,
              shouldCloseOnMinExtent: false,
              maxChildSize: 0.68,
              minChildSize: 0.4,
              initialChildSize: 0.68,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: const HomeListingWidget(),
                );
              },
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    titleAnimationController?.dispose();
    titleAnimationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: const Color(0xFFf8f8f8),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xfffed9b1), AppColor.lightGrey],
                focal: Alignment(1, 0.3),
                center: Alignment(0.7, 0.4),
                radius: 0.9,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [LocationWidget(), UserProfileWidget()],
                  ),
                  32.verticalSpace,
                  FadeTransition(
                    opacity: titleAnimationController!,
                    child: Text(
                      'Hi, Marina',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        // fontWeight: FontWeight.w500,
                        color: AppColor.grey,
                        height: 1.15,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  ClipRect(
                    child: SlideTransition(
                      position: textSlideAnimation,
                      child: Text(
                        'let\'s select your',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.sp,
                          // fontWeight: FontWeight.w500,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ),
                  ClipRect(
                    child: SlideTransition(
                      position: textSlideAnimation,
                      child: Text(
                        'perfect place',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.sp,
                          // fontWeight: FontWeight.w500,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ),
                  32.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HomeCountdownWidget(
                        countDown: 1034,
                        title: 'BUY',
                        textColor: Colors.white,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      HomeCountdownWidget(
                        countDown: 2212,
                        title: 'RENT',
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white38, Colors.white],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        textColor: const Color(0xFFa6957e),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
