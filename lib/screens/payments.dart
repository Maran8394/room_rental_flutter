import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/custom_text_button.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payments",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        leading: const Icon(
          Icons.payments_rounded,
          color: BrandingColors.primaryColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: <Widget>[
          Card(
            elevation: 0,
            color: BrandingColors.cardBackgroundColor,
            child: ListTile(
              leading: const Icon(
                Icons.apartment_outlined,
                color: BrandingColors.primaryColor,
              ),
              title: const Text("Rent"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    color: BrandingColors.danger,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.createBill);
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.createBill);
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            color: BrandingColors.cardBackgroundColor,
            child: ListTile(
              leading: const Icon(
                Icons.electric_bolt_outlined,
                color: BrandingColors.primaryColor,
              ),
              title: const Text("Electricity"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    color: BrandingColors.danger,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            color: BrandingColors.cardBackgroundColor,
            child: ListTile(
              leading: const Icon(
                Icons.construction_outlined,
                color: BrandingColors.primaryColor,
              ),
              title: const Text("Service"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    color: BrandingColors.danger,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            color: BrandingColors.cardBackgroundColor,
            child: ListTile(
              leading: const Icon(
                Icons.water_drop_rounded,
                color: BrandingColors.primaryColor,
              ),
              title: const Text("Water"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    color: BrandingColors.danger,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          CustomTextButton(
            isDisabled: true,
            text: "UPLOAD RECEIPT",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
