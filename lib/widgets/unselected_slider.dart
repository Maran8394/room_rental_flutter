import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class UnselectedSlider extends StatelessWidget {
  final bool isSlideVisible;
  final TickerProvider thisVsync;
  const UnselectedSlider({
    super.key,
    required this.isSlideVisible,
    required this.thisVsync,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: AnimationController(
            vsync: thisVsync,
            duration: const Duration(milliseconds: 200),
          )..forward(),
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: 20,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: BrandingColors.secondaryGray,
        ),
      ),
    );
  }
}
