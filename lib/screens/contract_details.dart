import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/cubits/user_data/user_data_cubit.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/label_and_value.dart';

class ContractDetails extends StatefulWidget {
  const ContractDetails({super.key});

  @override
  State<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  @override
  void initState() {
    super.initState();
    // context.read<UserDataCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contract Details",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
        children: [
          // Tenant Information
          Text(
            "Tenant Information",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BrandingColors.primaryColor,
                ),
          ),
          SizedBox(height: context.deviceHeight * 0.02),
          tenenatInfo(),
          SizedBox(height: context.deviceHeight * 0.02),

          // Rental Information
          Text(
            "Tenant Information",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BrandingColors.primaryColor,
                ),
          ),
          SizedBox(height: context.deviceHeight * 0.01),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BrandingColors.backgroundColor,
              border: Border.all(color: BrandingColors.borderColor),
            ),
            child: Column(
              children: [
                const LabelAndValue(
                  label: "Address",
                  value:
                      "Ampa Avenue, 3rd street, North street avenue, Maximus Road, Hong Kong - 12AS2341",
                ),
                ConstantWidgets.gapSizedBox(context),
                const LabelAndValue(label: "House No.", value: "A001"),
                ConstantWidgets.gapSizedBox(context),
                const LabelAndValue(label: "Property Code", value: "05004"),
                ConstantWidgets.gapSizedBox(context),
                const LabelAndValue(
                  label: "Agreement Period",
                  value: "01-05-2023 to 01-06-2024",
                ),
                ConstantWidgets.gapSizedBox(context),
                const LabelAndValue(label: "Rent", value: "HK\$ 124"),
                ConstantWidgets.gapSizedBox(context),
                const LabelAndValue(
                    label: "Security Deposit", value: "HK\$ 100"),
                ConstantWidgets.gapSizedBox(context),
              ],
            ),
          ),
          SizedBox(height: context.deviceHeight * 0.02),
          Text(
            "Miscellaneous Provisions",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BrandingColors.primaryColor,
                ),
          ),
          SizedBox(height: context.deviceHeight * 0.01),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BrandingColors.backgroundColor,
              border: Border.all(color: BrandingColors.borderColor),
            ),
            child: Text(
              'Any amendments or variation to this Agreement shall be in writing with the mutual consent of both parties.\nThis Agreement with any attachments constitutes the complete understanding of the parties to this Agreement regarding the subject matter contained in this Agreement and supersedes any and all other agreements or arrangements, either oral or in writing.\nAny notifications to be sent under this Agreement shall be in written form and delivered to the addresses of the parties indicated in this Agreement.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: BrandingColors.bodySmall.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          SizedBox(height: context.deviceHeight * 0.02),
          const CustomTextButton(text: "EXTEND CONTRACT"),
          const SizedBox(height: 5),
          const CustomTextButton(
            text: "I'M LEAVING HOME",
            needBorder: true,
            borderColor: BrandingColors.primaryColor,
            texColor: BrandingColors.primaryColor,
            backgroundColor: BrandingColors.backgroundColor,
          ),
          SizedBox(height: context.deviceHeight * 0.02),
        ],
      ),
    );
  }

  Widget tenenatInfo() {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserData) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BrandingColors.backgroundColor,
              border: Border.all(color: BrandingColors.borderColor),
            ),
            child: Column(
              children: [
                LabelAndValue(label: "Name", value: state.fullName!),
                ConstantWidgets.gapSizedBox(context),
                LabelAndValue(label: "Email ID", value: state.email!),
                ConstantWidgets.gapSizedBox(context),
                LabelAndValue(label: "Mobile Number", value: state.mobileNum!),
              ],
            ),
          );
        } else {
          return const Text("Something is wrong!");
        }
      },
    );
  }
}
