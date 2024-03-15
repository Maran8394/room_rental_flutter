import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  const EditPersonalDetailsPage({super.key});

  @override
  State<EditPersonalDetailsPage> createState() =>
      _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Details",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: const [
          // Name
          RequiredInputLabel(label: "Name"),
          SizedBox(height: 5),
          InputWidget(),
          SizedBox(height: 10),

          // User ID
          RequiredInputLabel(label: "User ID"),
          SizedBox(height: 5),
          InputWidget(readOnly: true),
          SizedBox(height: 10),

          // Email
          RequiredInputLabel(label: "Email ID"),
          SizedBox(height: 5),
          InputWidget(readOnly: true),
          SizedBox(height: 10),

          // Phone
          RequiredInputLabel(label: "Phone"),
          SizedBox(height: 5),
          InputWidget(),
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
