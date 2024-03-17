import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog? _dialog;
  final TextEditingController _oldPwd = TextEditingController();
  final TextEditingController _newPwd = TextEditingController();
  final TextEditingController _confirmPwd = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
          children: [
            // old pwd
            const RequiredInputLabel(label: "Old Password", isRequired: true),
            ConstantWidgets.labelSizedBox(context),
            InputWidget(
              hintText: "Enter Old Password",
              obsecureText: true,
              maxLines: 1,
              controller: _oldPwd,
              validator: (dynamic value) {
                if (value == null || value.isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            ConstantWidgets.gapSizedBox(context),

            // new pwd
            const RequiredInputLabel(label: "New Password", isRequired: true),
            ConstantWidgets.labelSizedBox(context),
            InputWidget(
              hintText: "Enter New Password",
              obsecureText: true,
              maxLines: 1,
              controller: _newPwd,
              validator: (dynamic value) {
                if (value == null || value.isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            ConstantWidgets.gapSizedBox(context),

            // confirm pwd
            const RequiredInputLabel(
                label: "Confirm Password", isRequired: true),
            ConstantWidgets.labelSizedBox(context),
            InputWidget(
              hintText: "Enter Confirm Password",
              obsecureText: true,
              maxLines: 1,
              controller: _confirmPwd,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocListener<ApplicationBloc, ApplicationState>(
        listener: (context, state) {
          if (state is ChangePasswordInit) {
            _dialog!.showAlertDialog(BrandingColors.primaryColor);
          }

          if (state is ChangePasswordDone) {
            _dialog!.dimissDialog();
            ConstantWidgets.showAlert(
              context,
              "Success",
              StateType.success,
            ).then((value) => Navigator.pop(context));
          }

          if (state is ChangePasswordFailed) {
            _dialog!.dimissDialog();
            ConstantWidgets.showAlert(
              context,
              state.errorMessage,
              StateType.error,
            );
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
                if (_newPwd.text.trim() == _confirmPwd.text.trim()) {
                  if (_confirmPwd.text.length < 8) {
                    ConstantWidgets.showAlert(
                      context,
                      "Please enter at least 8 characters",
                      StateType.error,
                    );
                  } else {
                    Map<String, dynamic> requestData = {
                      "old_password": _oldPwd.text.trim(),
                      "new_password": _newPwd.text.trim(),
                      "confirm_password": _confirmPwd.text.trim(),
                    };

                    context.read<ApplicationBloc>().add(
                          ChangePasswordEvent(
                            requestBody: requestData,
                          ),
                        );
                  }
                } else {
                  ConstantWidgets.showAlert(
                    context,
                    "Passwords not matched",
                    StateType.error,
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
