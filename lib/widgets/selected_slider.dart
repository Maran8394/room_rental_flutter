import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class SelectedSlider extends StatelessWidget {
  const SelectedSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BrandingColors.primaryColor,
      ),
    );
  }
}
