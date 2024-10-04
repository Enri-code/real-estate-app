import 'package:flutter/material.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

class MapFilterWidget extends StatelessWidget {
  const MapFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 1800,
      duration: 500,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(
          Icons.tune,
          size: 15,
        ),
      ),
    );
  }
}
