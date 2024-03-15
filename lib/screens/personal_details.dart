import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/label_and_value.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Details",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                showBottomSheet();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BrandingColors.backgroundColor,
              border: Border.all(color: BrandingColors.borderColor),
            ),
            child: const Column(
              children: [
                LabelAndValue(label: "Name", value: "John"),
                SizedBox(height: 10),
                LabelAndValue(label: "Email ID", value: "jonathan@gmail.com"),
                SizedBox(height: 10),
                LabelAndValue(label: "User ID", value: "CHN128902"),
                SizedBox(height: 10),
                LabelAndValue(label: "Phone No", value: "+9155266333"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: BrandingColors.backgroundColor,
      context: context,
      elevation: 0,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          height: context.deviceHeight * 0.18,
          width: context.deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 3,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 100.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: BrandingColors.listTileTitleColor,
                ),
              ),
              ListTile(
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                dense: true,
                leading: const Icon(
                  Icons.edit,
                  color: BrandingColors.primaryColor,
                ),
                title: Text(
                  "Edit",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    Routes.editPersonalDetailsPage,
                  );
                },
              ),
              ListTile(
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                dense: true,
                leading: SvgPicture.asset(AssetsPath.changePasswordSVGIcon),
                title: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    Routes.changePassword,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
