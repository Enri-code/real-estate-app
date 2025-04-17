import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_countdown_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_listing_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/location_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/user_profile_widget.dart';
import 'package:real_estate_app/src/core/theme/app_color.dart';
import 'package:real_estate_app/src/core/constants/constants.dart';

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
      duration: kDuration1Sec,
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
      curve: Curves.easeOutQuad,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(kDuration1_5Sec).then((_) {
        return titleAnimationController?.forward();
      });
      Future.delayed(kDuration800Mil * 5).then((_) {
        key.currentState?.showBottomSheet(
          backgroundColor: Colors.transparent,
          sheetAnimationStyle: AnimationStyle(
            duration: kDuration1Sec,
            curve: Curves.easeInOut,
          ),
          (context) {
            // This is calculated like this due to the elements of the page
            // being composed of both proportional and fixed values
            final minHeight = (500.h - 160) / 1.sh;
            return DraggableScrollableSheet(
              snap: true,
              expand: false,
              shouldCloseOnMinExtent: false,
              maxChildSize: 0.7,
              minChildSize: minHeight,
              // minChildSize: 0.44,
              initialChildSize: 0.7,
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
                focal: Alignment(0.8, 0),
                center: Alignment(0.5, 0.1),
                radius: 0.8,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [LocationWidget(), UserProfileWidget()],
                  ),
                  32.verticalSpace,
                  FadeTransition(
                    opacity: titleAnimationController!,
                    child: const Text(
                      'Hi, Marina',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey,
                        height: 1,
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  ClipRect(
                    child: SlideTransition(
                      position: textSlideAnimation,
                      child: Text(
                        'let\'s select your',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w500,
                          height: .9,
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
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w500,
                          height: .9,
                        ),
                      ),
                    ),
                  ),
                  48.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: HomeCountdownWidget(
                            countDown: 1034,
                            title: 'BUY',
                            textColor: Colors.white,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Flexible(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: HomeCountdownWidget(
                            countDown: 2212,
                            title: 'RENT',
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.white54, Colors.white],
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            textColor: const Color(0xFFa6957e),
                          ),
                        ),
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
