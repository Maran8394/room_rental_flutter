// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/blocs/cubits/user_data/user_data_cubit.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  const EditPersonalDetailsPage({super.key});

  @override
  State<EditPersonalDetailsPage> createState() =>
      _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog? dialog;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dialog = ProgressDialog(context);
    context.read<UserDataCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Details",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: BlocListener<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if (state is UserData) {
            setState(() {
              _firstNameController.text = state.firstName!;
              _lastNameController.text = state.lastName!;
              _emailController.text = state.email!;
              _phoneController.text = state.mobileNum!;
            });
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            children: [
              // First Name
              const RequiredInputLabel(label: "First Name", isRequired: true),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: _firstNameController,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Last Name
              const RequiredInputLabel(label: "Last Name", isRequired: true),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: _lastNameController,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Email
              const RequiredInputLabel(label: "Email ID", isRequired: true),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                readOnly: true,
                controller: _emailController,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Phone
              const RequiredInputLabel(label: "Phone", isRequired: true),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: _phoneController,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocListener<ApplicationBloc, ApplicationState>(
        listener: (context, state) async {
          if (state is UserDataUpdateInitState) {
            dialog!.showAlertDialog(
              BrandingColors.primaryColor,
            );
          } else if (state is UserDataUpdateDone) {
            var responseData = state.responseData;

            Map<String, String> toStore = {
              StorageKeys.fullName: responseData.full_name!,
              StorageKeys.userId: responseData.id.toString(),
              StorageKeys.email: responseData.email!,
              StorageKeys.phoneNo: responseData.mobile_number!,
              StorageKeys.firstName: responseData.first_name!,
              StorageKeys.lastName: responseData.last_name!,
            };
            await Storage.setAllValue(toStore);
            context.read<UserDataCubit>().getUserData();
            dialog!.dimissDialog();

            ConstantWidgets.showAlert(
              context,
              "Updated",
              StateType.success,
            ).then((value) => Navigator.pop(context));
          } else if (state is UserDataUpdateFailed) {
            dialog!.dimissDialog();
          }
        },
        child: SizedBox(
          height: context.buttonHeight,
          width: context.deviceWidth * 0.90,
          child: FloatingActionButton.small(
            elevation: 0,
            backgroundColor: BrandingColors.primaryColor,
            child: Text(
              "UPDATE",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Map<String, dynamic> requestData = {
                  "first_name": _firstNameController.text.trim(),
                  "last_name": _lastNameController.text.trim(),
                  "email": _emailController.text.trim(),
                  "mobile_number": _phoneController.text.trim()
                };
                context.read<ApplicationBloc>().add(
                      UpdateUserDataEvent(requestBody: requestData),
                    );
              }
            },
          ),
        ),
      ),
    );
  }
}
