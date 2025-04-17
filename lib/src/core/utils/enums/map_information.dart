import 'package:real_estate_app/src/core/constants/app_images.dart';

enum MapInformation {
  price,
  cosyAreas,
  infrastructure,
  withoutLayers;

  String get icon {
    switch (this) {
      case price:
        return AppImages.price;
      case cosyAreas:
        return AppImages.building;
      case infrastructure:
        return AppImages.infrastructure;
      case withoutLayers:
        return AppImages.mapLayer;
    }
  }

  String get displayName {
    switch (this) {
      case price:
        return 'Price';
      case cosyAreas:
        return 'Cosy Areas';
      case infrastructure:
        return 'Infrastructure';
      case withoutLayers:
        return 'Without layers';
    }
  }
}
