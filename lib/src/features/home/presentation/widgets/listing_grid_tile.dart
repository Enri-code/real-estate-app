import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class ListingGridTile extends StatefulWidget {
  const ListingGridTile({super.key, required this.listing});

  final HomeListing listing;

  @override
  State<ListingGridTile> createState() => _ListingGridTileState();
}

class _ListingGridTileState extends State<ListingGridTile>
    with SingleTickerProviderStateMixin {
  final double circleWidth = 50.r;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        image: DecorationImage(
          image: AssetImage(widget.listing.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Blur(
        blur: 2.5,
        blurColor: AppColor.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(40.r),
        overlay: Padding(
          padding: EdgeInsets.all(5.r),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.listing.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColor.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
