// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  UserRepo repo = UserRepo();
  ProgressDialog? dialog;
  UserBloc? _bloc;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obsecurePassword = true;

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc(repo);
    dialog = ProgressDialog(context);
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.backgroundColor,
      body: BlocConsumer<UserBloc, UserBlocState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is SiginInitState) {
            dialog!.showAlertDialog(
              BrandingColors.primaryColor,
            );
          }
          if (state is SigninSuccessState) {
            Map<String, String> toStore = {
              StorageKeys.accessToken:
                  state.responseModel.response_data!.access!,
              StorageKeys.fullName:
                  state.responseModel.response_data!.full_name!,
              StorageKeys.userId: state.responseModel.response_data!.user_id!,
              StorageKeys.profilePic:
                  state.responseModel.response_data!.profile_pic!,
            };
            dialog!.dimissDialog();

            await Storage.setAllValue(toStore);

            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   Routes.dashboard,
            //   (route) => false,
            // );
            Navigator.popAndPushNamed(
              context,
              Routes.indexPage,
              arguments: const IndexingPage(
                selectedIndex: 0,
              ),
            );
          }
          if (state is SigninFailureState) {
            dialog!.dimissDialog();
            String? errorMessage = state.responseModel.errors!.first!.message;
            ConstantWidgets.showAlert(context, errorMessage, StateType.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: context.deviceHeight,
              width: context.deviceWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 80,
                      child: FlutterLogo(
                        size: context.deviceWidth / 3,
                      ),
                    ),
                    SizedBox(
                      height: context.gapHeight,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logo,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: context.gapHeight),
                    Text(
                      AppLocalizations.of(context)!.logoSubtext,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: context.gapHeight,
                    ),
                    InputWidget(
                      keyboardType: TextInputType.emailAddress,
                      controller: _mobileNumberController,
                      hintText: AppLocalizations.of(context)!.emailPlaceholder,
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
                      controller: _passwordController,
                      obsecureText: obsecurePassword,
                      hintText:
                          AppLocalizations.of(context)!.passwordPlaceholder,
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (obsecurePassword == true) {
                            setState(() {
                              obsecurePassword = false;
                            });
                          } else {
                            setState(() {
                              obsecurePassword = true;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: (obsecurePassword)
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
                    Center(
                      child: SizedBox(
                        width: context.deviceWidth,
                        child: CustomTextButton(
                          text: AppLocalizations.of(context)!.login,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _bloc!.add(
                                SigninEvent(
                                  userName: _mobileNumberController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: context.gapHeight),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgotPassword);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgotPassword,
                        style: const TextStyle(
                          color: BrandingColors.textColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
