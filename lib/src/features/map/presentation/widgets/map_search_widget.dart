import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapSearchWidget extends StatelessWidget {
  const MapSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            height: 45.h,
            width: 45.h,
            alignment: Alignment.center,
            child: const Icon(Icons.search),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                isDense: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
