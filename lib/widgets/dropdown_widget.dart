import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.selectedRequestType,
    required this.dropDownItems,
  });

  final String selectedRequestType;
  final List<String> dropDownItems;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedRequestType,
      isDense: false,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 2),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
      items: dropDownItems
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        debugPrint(value!.toLowerCase());
      },
      buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: BrandingColors.borderColor),
          )),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 20,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: context.deviceHeight / 3.5,
        width: context.deviceHeight / 1.92,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: BrandingColors.borderColor),
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
    );
  }
}