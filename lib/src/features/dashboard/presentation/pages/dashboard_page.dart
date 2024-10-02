import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/dashboard/presentation/widgets/navigation_tab_icon.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // navigation tab controller

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // dispose tab controller
    super.dispose();
  }

  Widget currentPage() {
    switch (tabIndex) {
      case 0:
        return Container(color: Colors.red);
      case 1:
        return Container(color: Colors.blue);
      case 2:
        return Container(color: Colors.white);
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
            duration: const Duration(milliseconds: 1000),
            child: currentPage(),
          ),
          Positioned(
            bottom: 20.h,
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
          )
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
