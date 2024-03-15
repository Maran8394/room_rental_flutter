import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? selectedMonth;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMonth = "Feb";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackButton(color: BrandingColors.primaryColor),
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Text(
            "June",
            style: ConstantStyles.bodyTitleStyle(context),
          ),
          Card(
            elevation: 0,
            color: BrandingColors.containerBorderColor,
            child: ListTile(
              dense: true,
              leading: const Icon(
                Icons.build_rounded,
                color: BrandingColors.primaryColor,
              ),
              title: Text(
                "Maintenance request has been resolved",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                "Please find the attached bill here",
                style: TextStyle(
                  color: BrandingColors.listTileTitleColor.withOpacity(0.6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "May",
            style: ConstantStyles.bodyTitleStyle(context),
          ),
          Card(
            elevation: 0,
            color: BrandingColors.containerBorderColor,
            child: ListTile(
              leading: const Icon(
                Icons.payments_rounded,
                color: BrandingColors.primaryColor,
              ),
              title: Text(
                "Your rent is now available for the payment",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                "Click here to upload",
                style: TextStyle(
                  color: BrandingColors.listTileTitleColor.withOpacity(0.6),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
