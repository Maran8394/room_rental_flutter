import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/chips_widets.dart';
import 'package:room_rental/widgets/month_dropdown.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.construction_rounded,
          color: BrandingColors.primaryColor,
        ),
        title: Text(
          "Services",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MonthDropdown(
              selectedMonth: "Feb",
              size: size,
              height: size.height / 20,
              width: size.width / 4,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: [
          Text(
            "May",
            style: ConstantStyles.bodyTitleStyle(context),
          ),
          Card(
            elevation: 0,
            color: BrandingColors.cardBackgroundColor,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              leading: const Icon(
                Icons.ac_unit_outlined,
                color: Colors.black,
              ),
              isThreeLine: true,
              title: const Text("Air Conditioner"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Service request (High)",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Done service 6 months back",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RequestedChip(),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      showBottomSheet();
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.deviceWidth * 0.80,
        child: FloatingActionButton.small(
          elevation: 0,
          backgroundColor: BrandingColors.primaryColor,
          child: Text(
            "RAISE NEW REQUEST",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.createNewRequestPage,
            );
          },
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: BrandingColors.cardBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          height: context.deviceHeight * 0.26,
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
              ),
              ListTile(
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                dense: true,
                leading: const Icon(
                  Icons.check_circle,
                  color: BrandingColors.primaryColor,
                ),
                title: Text(
                  "Mark as resolved",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              ListTile(
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                dense: true,
                leading: const Icon(
                  Icons.cancel,
                  color: BrandingColors.danger,
                ),
                title: Text(
                  "Cancel Request",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
