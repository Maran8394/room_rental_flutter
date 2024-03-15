import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/screens/reset_password_success.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';

class ResetPassword extends StatefulWidget {
  final String userName;
  const ResetPassword({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  UserBloc? _bloc;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obsecurePassword1 = true;
  bool obsecurePassword2 = true;
  ProgressDialog? dialog;

  @override
  void initState() {
    super.initState();
    UserRepo userRepo = UserRepo();
    _bloc = UserBloc(userRepo);
    dialog = ProgressDialog(context);
  }

  @override
  void dispose() {
    _bloc!.close();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: BlocConsumer<UserBloc, UserBlocState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ResetPasswordInitState) {
            dialog!.showAlertDialog(
              BrandingColors.primaryColor,
            );
          }
          if (state is ResetPasswordSuccessState) {
            dialog!.dimissDialog();

            Navigator.popAndPushNamed(
              context,
              Routes.resetPasswordSuccessPage,
              arguments: ResetPasswordSuccessPage(
                userName: state.responseModel.request_data!.user_name!,
                password: state.responseModel.request_data!.password!,
              ),
            );
          }
          if (state is ResetPasswordFailureState) {
            dialog!.dimissDialog();
            String? errorMessage = state.responseModel.errors!.first!.message;
            ConstantWidgets.showAlert(context, errorMessage, StateType.error);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SvgPicture.asset(
                  AssetsPath.resetPassword,
                ),
                SizedBox(height: context.gapHeight),
                Text(
                  "Reset Password?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: context.gapHeight),
                InputWidget(
                  maxLines: 1,
                  controller: _passwordController,
                  obsecureText: obsecurePassword1,
                  hintText: "Password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AssetsPath.lockIcon,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (obsecurePassword1 == true) {
                        setState(() {
                          obsecurePassword1 = false;
                        });
                      } else {
                        setState(() {
                          obsecurePassword1 = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (obsecurePassword1)
                          ? SvgPicture.asset(
                              AssetsPath.strikedEyeIcon,
                            )
                          : SvgPicture.asset(
                              AssetsPath.eyeIcon,
                            ),
                    ),
                  ),
                  validator: (dynamic value) {
                    if (value == null || value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.gapHeight),
                InputWidget(
                  maxLines: 1,
                  obsecureText: obsecurePassword2,
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AssetsPath.lockIcon,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (obsecurePassword2 == true) {
                        setState(() {
                          obsecurePassword2 = false;
                        });
                      } else {
                        setState(() {
                          obsecurePassword2 = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (obsecurePassword2)
                          ? SvgPicture.asset(
                              AssetsPath.strikedEyeIcon,
                            )
                          : SvgPicture.asset(
                              AssetsPath.eyeIcon,
                            ),
                    ),
                  ),
                  validator: (dynamic value) {
                    if (value == null || value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.gapHeight),
                CustomTextButton(
                  text: "Reset Password",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        _bloc!.add(
                          ResetPasswordEvent(
                            userName: widget.userName,
                            password: _passwordController.text,
                          ),
                        );
                      } else {
                        ConstantWidgets.showAlert(
                          context,
                          "Passwords not matched",
                          StateType.error,
                        );
                      }
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
