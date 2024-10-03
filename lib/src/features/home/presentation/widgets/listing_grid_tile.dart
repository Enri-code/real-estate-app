import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class ListingGridTile extends StatefulWidget {
  const ListingGridTile({
    super.key,
  });

  @override
  State<ListingGridTile> createState() => _ListingGridTileState();
}

class _ListingGridTileState extends State<ListingGridTile> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4)).then((_) {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.blue.withOpacity(0.1),
      ),
      child: AnimatedContainer(
        padding: EdgeInsets.all(5.r),
        duration: const Duration(milliseconds: 600),
        height: 50.r,
        width: startAnimation ? double.maxFinite : 50.r,
        // alignment: startAnimation ? Alignment.centerRight : Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Som other text',
                textAlign: TextAlign.center,
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
    );
  }
}
