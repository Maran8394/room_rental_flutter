import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class ConstantStyles {
  static TextStyle bodyTitleStyle(context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: BrandingColors.titleColor,
            fontWeight: FontWeight.bold,
          );
  static TextStyle bodyContentStyle(context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            color: BrandingColors.titleColor,
          );
}
