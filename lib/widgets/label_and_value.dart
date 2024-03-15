import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class LabelAndValue extends StatelessWidget {
  final String label;
  final String value;
  const LabelAndValue({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: BrandingColors.primaryColor,
                ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: BrandingColors.bodySmall,
                ),
          ),
        )
      ],
    );
  }
}
