import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/dashboard/presentation/widgets/navigation_tab_icon.dart';
import 'package:real_estate_app/src/features/home/presentation/pages/home_page.dart';
import 'package:real_estate_app/src/features/map/presentation/pages/map_page.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  // animation controller for navigation tab
  late AnimationController controller;
  late Animation animation;

  final Duration pageFadeDuration = const Duration(milliseconds: 1000);
  final Duration navbarDuration = const Duration(milliseconds: 1000);
  final Duration navbarDelay = const Duration(seconds: 3);

  int tabIndex = 2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: navbarDuration,
      vsync: this,
    );
    animation = Tween<double>(begin: -10.0, end: 20.0).animate(controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNavbar();
    });
  }

  @override
  void dispose() {
    // dispose animation controller
    controller.dispose();
    super.dispose();
  }

  Future<void> showNavbar() async {
    await Future.delayed(navbarDelay);
    controller.forward();
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: pageFadeDuration,
            child: currentPage(),
          ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavigationTabIcon(
                          icon: Icons.maps_ugc,
                          selected: 0 == tabIndex,
                          onTap: () => changeTab(0),
                        ),
                        NavigationTabIcon(
                          icon: Icons.message_rounded,
                          selected: 1 == tabIndex,
                          onTap: () => changeTab(1),
                        ),
                        NavigationTabIcon(
                          icon: Icons.home,
                          selected: 2 == tabIndex,
                          onTap: () => changeTab(2),
                        ),
                        NavigationTabIcon(
                          icon: Icons.favorite,
                          selected: 3 == tabIndex,
                          onTap: () => changeTab(3),
                        ),
                        NavigationTabIcon(
                          icon: Icons.person,
                          selected: 4 == tabIndex,
                          onTap: () => changeTab(4),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void changeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}
