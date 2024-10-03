import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/listing_grid_tile.dart';

class HomeListingWidget extends StatefulWidget {
  const HomeListingWidget({
    super.key,
  });

  @override
  State<HomeListingWidget> createState() => _HomeListingWidgetState();
}

class _HomeListingWidgetState extends State<HomeListingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    slideAnimation = Tween(begin: 0.0, end: 1.0).animate(controller!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1800)).then((_) {
        controller?.forward();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slideAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 0.8.sh * slideAnimation.value,
            child: Container(
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 8.r,
                crossAxisSpacing: 8.r,
                children: List.generate(4, (index) {
                  return gridTile(index);
                }),
              ),
            ),
          );
        });
  }

  Widget gridTile(int index) {
    int x;
    int y;
    switch (index % 4) {
      case 0:
        x = 4;
        y = 2;
        break;
      case 1:
        x = 2;
        y = 4;
        break;
      case 2:
        x = 2;
        y = 2;
        break;
      case 3:
        x = 2;
        y = 2;
        break;
      default:
        throw Exception('wrong index');
    }
    return StaggeredGridTile.count(
      crossAxisCellCount: x,
      mainAxisCellCount: y,
      child: const ListingGridTile(),
    );
  }
}
