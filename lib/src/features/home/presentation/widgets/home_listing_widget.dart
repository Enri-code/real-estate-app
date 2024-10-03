import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/listing_grid_tile.dart';

class HomeListingWidget extends StatelessWidget {
  const HomeListingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8.r,
      crossAxisSpacing: 8.r,
      children: List.generate(4, (index) {
        return gridTile(index);
      }),
    );
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
      child: ListingGridTile(
        widthRatio: x,
        heightRatio: y,
      ),
    );
  }
}
