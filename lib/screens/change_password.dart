import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: const [
          // old pwd
          RequiredInputLabel(label: "Old Password"),
          SizedBox(height: 5),
          InputWidget(
            hintText: "Enter Old Password",
          ),
          SizedBox(height: 10),

          // new pwd
          RequiredInputLabel(label: "New Password"),
          SizedBox(height: 5),
          InputWidget(
            hintText: "Enter New Password",
          ),
          SizedBox(height: 10),

          // confirm pwd
          RequiredInputLabel(label: "Confirm Password"),
          SizedBox(height: 5),
          InputWidget(
            hintText: "Enter Confirm Password",
          ),
          SizedBox(height: 10),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.deviceWidth * 0.90,
        child: FloatingActionButton.small(
          elevation: 0,
          backgroundColor: BrandingColors.primaryColor,
          onPressed: () {},
          child: Text(
            "SAVE",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
