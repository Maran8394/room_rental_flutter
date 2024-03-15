// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obsecureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  const InputWidget({
    Key? key,
    this.hintText,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obsecureText,
    this.keyboardType,
    this.validator,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: (readOnly == true) ? true : false,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      obscureText: obsecureText ?? false,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      decoration: InputDecoration(
        errorStyle: const TextStyle(height: 0, fontSize: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: BrandingColors.borderColor,
          ),
        ),
        fillColor: (readOnly != true)
            ? BrandingColors.backgroundColor
            : BrandingColors.cardBackgroundColor,
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade400,
            ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: BrandingColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: BrandingColors.borderColor,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
