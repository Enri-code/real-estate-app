import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/dashboard/presentation/pages/dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 809), // const Size(428, 935),
      minTextAdapt: true,
      ensureScreenSize: true,
      fontSizeResolver: FontSizeResolvers.height,
      child: MaterialApp(
        title: 'Real Estate',
        builder: (_, widget) {
          return ScrollConfiguration(
            behavior: const _GlobalScrollBehavior(),
            child: widget!,
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DashboardPage(),
      ),
    );
  }
}

class _GlobalScrollBehavior extends ScrollBehavior {
  const _GlobalScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}
