// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? texColor;
  final Color? borderColor;
  final bool? needBorder;
  final Function()? onPressed;
  final bool? isDisabled;
  final TextStyle? textStyle;
  const CustomTextButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.texColor,
    this.borderColor,
    this.needBorder,
    this.onPressed,
    this.isDisabled,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: (isDisabled == true)
            ? MaterialStatePropertyAll(
                BrandingColors.primaryColor.withOpacity(0.5))
            : MaterialStatePropertyAll(
                backgroundColor ?? BrandingColors.primaryColor,
              ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: (needBorder == true)
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: texColor ?? BrandingColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
      ),
    );
  }
}
