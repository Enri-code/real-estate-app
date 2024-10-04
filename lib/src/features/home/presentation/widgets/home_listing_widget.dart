import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/features/home/presentation/widgets/listing_grid_tile.dart';

class HomeListingWidget extends StatelessWidget {
  const HomeListingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8.r,
        crossAxisSpacing: 8.r,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: ListingGridTile(listing: HomeListing.data[0]),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: ListingGridTile(listing: HomeListing.data[1]),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ListingGridTile(listing: HomeListing.data[2]),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ListingGridTile(listing: HomeListing.data[3]),
          ),
        ],
      ),
    );
  }
}
