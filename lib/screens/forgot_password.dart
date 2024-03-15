import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/screens/verify_otp.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/back_button.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  UserBloc? _bloc;
  ProgressDialog? dialog;

  @override
  void initState() {
    super.initState();
    UserRepo userRepo = UserRepo();
    _bloc = UserBloc(userRepo);
    dialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        centerTitle: true,
        leading: const CustomBackButton(),
      ),
      body: BlocConsumer<UserBloc, UserBlocState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ForgotPasswordInitState) {
            dialog!.showAlertDialog(
              BrandingColors.primaryColor,
            );
          }
          if (state is ForgotPasswordSuccessState) {
            dialog!.dimissDialog();
            Navigator.popAndPushNamed(
              context,
              Routes.verifyOTP,
              arguments: VerifyOTP(
                otp: state.responseModel.response_data!.otp!,
                userName: state.responseModel.request_data!.userName!,
              ),
            );
          }
          if (state is ForgotPasswordFailureState) {
            dialog!.dimissDialog();
            String? errorMessage = state.responseModel.errors!.first!.message;
            ConstantWidgets.showAlert(context, errorMessage, StateType.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.forgotPassword,
                ),
                SizedBox(height: context.gapHeight),
                Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: context.gapHeight),
                Text(
                  AppLocalizations.of(context)!.forgotPasswordSubtext,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: context.gapHeight),
                Form(
                  key: _formKey,
                  child: InputWidget(
                    keyboardType: TextInputType.emailAddress,
                    controller: userNameController,
                    hintText: AppLocalizations.of(context)!.emailPlaceholder,
                    validator: (dynamic value) {
                      if (value == null || value.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: context.gapHeight2),
                SizedBox(
                  width: context.deviceWidth,
                  height: context.buttonHeight,
                  child: CustomTextButton(
                    text: AppLocalizations.of(context)!
                        .forgotPasswordContinue
                        .toUpperCase(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _bloc!.add(
                          ForgotPasswordEvent(
                            userName: userNameController.text,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
