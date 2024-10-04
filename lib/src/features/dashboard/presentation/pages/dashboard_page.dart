import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/dashboard/presentation/widgets/navigation_tab_icon.dart';
import 'package:real_estate_app/src/features/home/presentation/pages/home_page.dart';
import 'package:real_estate_app/src/features/map/presentation/pages/map_page.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  // animation controller for navigation tab
  late AnimationController? dashboardAnimController;
  late Animation animation;

  int tabIndex = 2;

  final Duration navbarDelay = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    dashboardAnimController =
        AnimationController(duration: kDuration1Sec, vsync: this);
    animation = Tween<double>(begin: -100.0, end: 20.0).animate(CurvedAnimation(
      parent: dashboardAnimController!,
      curve: Curves.easeOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNavbar();
    });
  }

  @override
  void dispose() {
    // dispose animation controller
    dashboardAnimController?.dispose();
    dashboardAnimController = null;
    super.dispose();
  }

  void showNavbar() {
    Future.delayed(kDuration3Sec, () => dashboardAnimController?.forward());
  }

  Widget currentPage() {
    switch (tabIndex) {
      case 0:
        return const MapPage();
      case 1:
        return Container(color: Colors.blue);
      case 2:
        return const HomePage();
      case 3:
        return Container(color: Colors.green);
      case 4:
        return Container(color: Colors.purple);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(duration: kDuration1Sec, child: currentPage()),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Positioned(
              bottom: animation.value,
              right: 50.w,
              left: 50.w,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.maxFinite,
                  height: 60.h,
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(30.h),
                  ),
                  child: CustomNavBar(tabIndex: tabIndex, changeTab: changeTab),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void changeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}
