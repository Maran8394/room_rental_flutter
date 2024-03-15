import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/widgets/key_and_value.dart';

class PropertyCard extends StatelessWidget {
  final String propertyImageUrl;
  final String flatNo;
  final String address;
  const PropertyCard({
    Key? key,
    required this.propertyImageUrl,
    required this.flatNo,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: BrandingColors.containerBorderColor,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              propertyImageUrl,
              fit: BoxFit.cover, // Adjust fit as needed
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                KeyAndValue(
                  keyString: "Flat",
                  valueString: flatNo,
                ),
                const SizedBox(height: 10),
                KeyAndValue(
                  keyString: "Address",
                  valueString: address,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
