import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:real_estate_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:real_estate_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:real_estate_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';

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
          return RepositoryProvider<HomeRepository>(
            create: (context) => HomeRepositoryImpl(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => MapBloc()),
                BlocProvider(
                  create: (context) => HomeBloc(context.read<HomeRepository>())
                    ..add(LoadHomeListing()),
                ),
              ],
              child: ScrollConfiguration(
                behavior: const _GlobalScrollBehavior(),
                child: widget!,
              ),
            ),
          );
        },
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Afacad_Flux',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
