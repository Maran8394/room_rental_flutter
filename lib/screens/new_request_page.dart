import 'package:flutter/material.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/constant_values.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/dropdown_widget.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  String selectedRequestType = "Plumbing";
  String selectedCategory = "Repair";
  String selectedPriority = "Normal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "New Request",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          const RequiredInputLabel(
            label: "Type",
            isRequired: true,
          ),
          const SizedBox(height: 5),
          DropDownWidget(
            selectedValue: selectedRequestType,
            dropDownItems: ConstantValues.serviceRequestTypes,
          ),
          const SizedBox(height: 10),
          const RequiredInputLabel(
            label: "Category",
            isRequired: true,
          ),
          const SizedBox(height: 5),
          DropDownWidget(
            selectedValue: selectedCategory,
            dropDownItems: ConstantValues.serviceCategories,
          ),
          const SizedBox(height: 10),
          const RequiredInputLabel(
            label: "Priority",
            isRequired: true,
          ),
          const SizedBox(height: 5),
          DropDownWidget(
            selectedValue: selectedPriority,
            dropDownItems: ConstantValues.priorities,
          ),
          const SizedBox(height: 10),
          const RequiredInputLabel(label: "Description"),
          const SizedBox(height: 5),
          const InputWidget(maxLines: 3),
          const SizedBox(height: 10),
          const RequiredInputLabel(label: "Upload Reference Document"),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: BrandingColors.containerBorderColor,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.black,
                      weight: 10,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Upload File",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const CustomTextButton(
            text: "DONE",
          ),
        ],
      ),
    );
  }
}
