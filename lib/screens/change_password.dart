import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
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
        children: [
          // old pwd
          const RequiredInputLabel(label: "Old Password", isRequired: true),
          ConstantWidgets.labelSizedBox(context),
          const InputWidget(
            hintText: "Enter Old Password",
            obsecureText: true,
            maxLines: 1,
          ),
          ConstantWidgets.gapSizedBox(context),

          // new pwd
          const RequiredInputLabel(label: "New Password", isRequired: true),
          ConstantWidgets.labelSizedBox(context),
          const InputWidget(
            hintText: "Enter New Password",
            obsecureText: true,
            maxLines: 1,
          ),
          ConstantWidgets.gapSizedBox(context),

          // confirm pwd
          const RequiredInputLabel(label: "Confirm Password", isRequired: true),
          ConstantWidgets.labelSizedBox(context),
          const InputWidget(
            hintText: "Enter Confirm Password",
            obsecureText: true,
            maxLines: 1,
          ),
          ConstantWidgets.gapSizedBox(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: context.buttonHeight,
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
