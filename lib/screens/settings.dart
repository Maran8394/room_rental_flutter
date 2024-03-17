// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/cubits/user_data/user_data_cubit.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? fullName;
  String? email;
  String? profilePic;

  @override
  void initState() {
    super.initState();
  }

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
          // UserData
          userData(),
          const SizedBox(height: 20),

          // Lists
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
          ListTile(
            tileColor: BrandingColors.cardBackgroundColor,
            title: const Text(
              "Logout",
            ),
            leading: const Icon(
              Icons.logout_outlined,
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
            onTap: () async {
              await Storage.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.signIn,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget userData() {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserData) {
          return Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.06,
                  backgroundImage:
                      (state.profilePic != null && state.profilePic!.isNotEmpty)
                          ? NetworkImage(
                              state.profilePic!,
                            )
                          : const AssetImage(
                              AssetsPath.lanlord,
                            ) as ImageProvider<Object>?,
                ),
              ),
              Center(
                child: Text(
                  state.fullName!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Center(
                child: Text(state.email!),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
