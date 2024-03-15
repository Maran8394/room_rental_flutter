import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        leading: const Icon(
          Icons.settings,
          color: BrandingColors.primaryColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: [
          Center(
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.06,
              backgroundImage: const NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=3569&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
            ),
          ),
          Center(
            child: Text(
              "Maran",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Center(
            child: Text("maran8394@gmail.com"),
          ),
          const SizedBox(height: 20),
          ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: const Text(
              "Personal Details",
            ),
            leading: const Icon(
              Icons.person,
              color: BrandingColors.primaryColor,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
            onTap: () =>
                Navigator.pushNamed(context, Routes.personalDetailsPage),
          ),
          ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: const Text(
              "Contract Details",
            ),
            leading: const Icon(
              Icons.home_work_rounded,
              color: BrandingColors.primaryColor,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
            onTap: () =>
                Navigator.pushNamed(context, Routes.contractDetailsPage),
          ),
          ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: const Text("Notifications"),
            leading: const Icon(
              Icons.notifications,
              color: BrandingColors.primaryColor,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
            onTap: () => Navigator.pushNamed(context, Routes.notificationsPage),
          ),
          ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: const Text("Languages"),
            leading: const Icon(
              Icons.language,
              color: BrandingColors.primaryColor,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
            onTap: () => Navigator.pushNamed(context, Routes.languagesPage),
          ),
          const ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: Text(
              "Privacy and Security",
            ),
            leading: Icon(
              Icons.security_outlined,
              color: BrandingColors.primaryColor,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
            // trailing:
          ),
          const ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: Text(
              "Help and Support",
            ),
            leading: Icon(
              Icons.help_outlined,
              color: BrandingColors.primaryColor,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 15,
              weight: 20,
              grade: 20,
              fill: 1,
            ),
          ),
        ],
      ),
    );
  }
}
