import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app/src/features/home/presentation/bloc/home_bloc.dart';
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
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8.r,
            crossAxisSpacing: 8.r,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: ListingGridTile(listing: state.listing[0]),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 2,
                child: ListingGridTile(listing: state.listing[1]),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: ListingGridTile(listing: state.listing[2]),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: ListingGridTile(listing: state.listing[3]),
              ),
            ],
          );
        },
      ),
    );
  }
}
