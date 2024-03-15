// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/styles.dart';

class KeyAndValue extends StatelessWidget {
  final String keyString;
  final String valueString;
  const KeyAndValue({
    Key? key,
    required this.keyString,
    required this.valueString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            keyString,
            style: ConstantStyles.bodyContentStyle(context),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            valueString,
            style: ConstantStyles.bodyContentStyle(context),
          ),
        ),
      ],
    );
  }
}
