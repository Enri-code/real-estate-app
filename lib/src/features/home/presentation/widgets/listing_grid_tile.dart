import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class ListingGridTile extends StatefulWidget {
  const ListingGridTile({
    super.key,
    required this.listing,
    required this.isGridWide,
    required this.index,
  });
  final int index;
  final HomeListing listing;
  final bool isGridWide;

  @override
  State<ListingGridTile> createState() => _ListingGridTileState();
}

class _ListingGridTileState extends State<ListingGridTile>
    with SingleTickerProviderStateMixin {
  late final double circleWidth;
  bool scaleLabel = false;
  bool expandLabel = false;
  bool showText = false;

  @override
  void initState() {
    circleWidth = widget.isGridWide ? 38.w : 32.w;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(kDuration300Mil);
      await Future.delayed(Duration(milliseconds: widget.index * 100));
      if (!mounted) return;
      setState(() => scaleLabel = true);
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      setState(() => expandLabel = true);
      await Future.delayed(kDuration500Mil);
      if (!mounted) return;
      setState(() => showText = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: widget.isGridWide ? EdgeInsets.all(12.w) : EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        image: DecorationImage(
          image: AssetImage(widget.listing.image),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedScale(
        duration: kDuration500Mil,
        scale: scaleLabel ? 1 : 0,
        child: Blur(
          blur: 18,
          colorOpacity: 0.25,
          borderRadius: BorderRadius.circular(circleWidth),
          overlay: Stack(
            children: [
              Align(
                alignment: widget.isGridWide
                    ? Alignment.center
                    : const Alignment(-0.7, 0),
                child: AnimatedOpacity(
                  duration: kDuration500Mil,
                  curve: Curves.easeInOut,
                  opacity: showText ? 1 : 0,
                  child: Text(
                    widget.listing.text,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: circleWidth,
                  height: circleWidth,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.grey,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, consts) {
            return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: kDuration800Mil,
              height: circleWidth + 6.w,
              width: expandLabel ? consts.maxWidth : circleWidth + 6.w,
              padding: EdgeInsets.all(3.w),
            );
          }),
        ),
      ),
    );
  }
}


// class ListingGridTile extends StatefulWidget {
//   const ListingGridTile({
//     super.key,
//     required this.widthRatio,
//     required this.heightRatio,
//     required this.listing,
//   });

//   final int widthRatio;
//   final int heightRatio;
//   final HomeListing listing;

//   @override
//   State<ListingGridTile> createState() => _ListingGridTileState();
// }

// class _ListingGridTileState extends State<ListingGridTile>
//     with SingleTickerProviderStateMixin {
//   AnimationController? controller;
//   late Animation expandWidthAnimation;
//   late Animation expandHeightAnimation;
//   late Animation fadeAnimation;
//   late double maxSlideWidth;
//   late double circleWidth;

//   @override
//   void initState() {
//     super.initState();
//     maxSlideWidth = 345.w * (widget.widthRatio / 4);
//     circleWidth = 50.r;

//     controller = AnimationController(vsync: this, duration: kDuration800Mil);

//     expandWidthAnimation =
//         Tween(begin: circleWidth, end: maxSlideWidth).animate(
//       CurvedAnimation(parent: controller!, curve: Curves.easeIn),
//     );
//     expandWidthAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: circleWidth), weight: 30),
//       TweenSequenceItem(
//           tween: Tween(begin: circleWidth, end: maxSlideWidth), weight: 70),
//     ]).animate(
//       controller!,
//     );

//     expandHeightAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: circleWidth), weight: 30),
//       TweenSequenceItem(
//           tween: Tween(begin: circleWidth, end: circleWidth), weight: 70),
//     ]).animate(
//       controller!,
//     );

//     fadeAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 90),
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
//     ]).animate(controller!);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(kDuration2Sec).then((_) {
//         if (controller != null) {
//           controller!.forward();
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     controller = null;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: controller!,
//         builder: (context, child) {
//           return Container(
//             alignment: Alignment.bottomLeft,
//             padding: EdgeInsets.all(10.r),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.r),
//                 color: Colors.blue.withOpacity(0.1),
//                 image: DecorationImage(
//                   image: AssetImage(widget.listing.image),
//                   fit: BoxFit.cover,
//                 )),
//             child: SizedBox(
//               height: expandHeightAnimation.value,
//               width: expandWidthAnimation.value,
//               child: Blur(
//                 blur: 2.5,
//                 blurColor: AppColor.grey.withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(40.r),
//                 overlay: Padding(
//                   padding: EdgeInsets.all(5.r),
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Opacity(
//                           opacity: fadeAnimation.value,
//                           child: Text(
//                             widget.listing.text,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w500,
//                               color: AppColor.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           width: 40.r,
//                           height: 40.r,
//                           alignment: Alignment.center,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: const Icon(
//                             Icons.arrow_forward_ios,
//                             size: 12,
//                             color: AppColor.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 child: const SizedBox(),
//               ),
//             ),
//           );
//         });
//   }
// }
