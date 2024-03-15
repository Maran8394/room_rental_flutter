// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';

class RequiredInputLabel extends StatelessWidget {
  final String label;
  final bool? isRequired;
  const RequiredInputLabel({
    Key? key,
    required this.label,
    this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (isRequired == true)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: BrandingColors.danger,
              ),
            ),
        ],
      ),
    );
  }
}
