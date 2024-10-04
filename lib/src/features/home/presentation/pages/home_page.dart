import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_countdown_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/home_listing_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/location_widget.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/user_profile_widget.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/ui/translate_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState>? key = GlobalKey();
  PersistentBottomSheetController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1800)).then((_) async {
        if (key != null) {
          controller = key!.currentState!.showBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r))),
            (context) {
              return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.7,
                  maxChildSize: 0.7,
                  minChildSize: 0.4,
                  shouldCloseOnMinExtent: false,
                  snap: true,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: const HomeListingWidget(),
                    );
                  });
            },
          );
        }
      });
    });
  }

  @override
  void dispose() {
    key = null;
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
                colors: [Color(0xfffed9b1), Color(0xfff9f7f5)],
                focal: Alignment(1, 0.3),
                center: Alignment(0.7, 0.4),
                radius: 0.9,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                32.verticalSpace,
                Container(
                  height: 30.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ClipRRect(
                    child: TranslateAnimationWidget(
                      delay: 1000,
                      duration: 800,
                      offset: Offset(0, 30.h),
                      child: Text(
                        'Hi, Marina',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Container(
                  height: 120.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ClipRRect(
                    child: TranslateAnimationWidget(
                      delay: 1000,
                      duration: 800,
                      offset: Offset(0, 120.h),
                      child: Text(
                        'let\'s select your perfect place',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ),
                32.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCountdownWidget(
                        countDown: 982,
                        title: 'Buy',
                        subtitle: 'offers',
                        backgroundColor: AppColor.primary,
                        textColor: Colors.white,
                        borderRadius: 100.r,
                      ),
                      HomeCountdownWidget(
                        countDown: 1200,
                        title: 'Rent',
                        subtitle: 'offers',
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFFa6957e),
                        borderRadius: 20.r,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
