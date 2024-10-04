import 'package:flutter/material.dart';

enum MapInformation {
  price,
  cosyAreas,
  infrastructure,
  withoutLayers;

  IconData get icon {
    switch (this) {
      case price:
        return Icons.money;
      case cosyAreas:
        return Icons.apartment;
      case infrastructure:
        return Icons.settings_applications;
      case withoutLayers:
        return Icons.square;
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
