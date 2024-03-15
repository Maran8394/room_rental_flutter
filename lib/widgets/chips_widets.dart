import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class RequestedChip extends StatelessWidget {
  const RequestedChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: BrandingColors.danger,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
      ),
      child: const Text(
        "Requested",
        style: TextStyle(fontSize: 6, color: Colors.white),
      ),
    );
  }
}

class InProgressChip extends StatelessWidget {
  const InProgressChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: BrandingColors.warning,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
      ),
      child: const Text(
        "In Progress",
        style: TextStyle(fontSize: 6, color: Colors.black),
      ),
    );
  }
}

class SuccessChip extends StatelessWidget {
  const SuccessChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: BrandingColors.success,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
      ),
      child: const Text(
        "Success",
        style: TextStyle(fontSize: 6, color: Colors.white),
      ),
    );
  }
}
