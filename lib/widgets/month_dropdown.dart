// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/constant_values.dart';

class MonthDropdown extends StatelessWidget {
  const MonthDropdown({
    Key? key,
    required this.size,
    this.height,
    this.width,
    required this.selectedMonth,
    this.onChanged,
  }) : super(key: key);

  final Size size;
  final double? height;
  final double? width;
  final String? selectedMonth;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    double boxWidth = width ?? size.width / 3.5;

    return SizedBox(
      height: height ?? size.height / 16,
      width: boxWidth,
      child: DropdownButtonFormField2<String>(
        value: selectedMonth,
        isDense: false,
        decoration: InputDecoration(
          fillColor: BrandingColors.primaryColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
        items: ConstantValues.months
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: size.height / 3.5,
          width: boxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: BrandingColors.primaryColor,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
