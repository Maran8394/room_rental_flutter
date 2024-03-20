import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';

import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/screens/reset_password.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/back_button.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/progress_indicator.dart';

class VerifyOTP extends StatefulWidget {
  final String otp;
  final String userName;

  const VerifyOTP({
    Key? key,
    required this.otp,
    required this.userName,
  }) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  UserBloc? _bloc;
  ProgressDialog? dialog;
  bool otpSent = false;
  bool clearOtpField = false;
  Timer? _timer;
  int _timerCount = 29;
  TextEditingController enteredOTP = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserRepo userRepo = UserRepo();
    _bloc = UserBloc(userRepo);
    dialog = ProgressDialog(context);

    startTimer();
    setState(() {
      otpSent = true;
    });
  }

  @override
  void dispose() {
    _bloc!.close();
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timerCount == 0) {
          setState(() {
            timer.cancel();
            otpSent = false;
          });
        } else {
          setState(() {
            _timerCount--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: const CustomBackButton(),
      ),
      body: BlocConsumer<UserBloc, UserBlocState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ForgotPasswordInitState) {
            dialog!.showAlertDialog(BrandingColors.primaryColor);
          }
          if (state is ForgotPasswordSuccessState) {
            dialog!.dimissDialog();
            setState(() {
              _timerCount = 29;
              otpSent = true;
            });
            startTimer();
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
                  "Verify OTP",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: context.gapHeight),
                Text(
                  "OTP has sent to your email id",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: context.gapHeight),
                OtpTextField(
                    clearText: clearOtpField,
                    filled: true,
                    fillColor: BrandingColors.backgroundColor,
                    numberOfFields: 6,
                    borderColor: BrandingColors.borderColor,
                    focusedBorderColor: BrandingColors.primaryColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      setState(() {
                        clearOtpField = false;
                      });
                    },
                    onSubmit: (String verificationCode) {
                      setState(() {
                        enteredOTP.text = verificationCode;
                      });
                    }),
                SizedBox(height: context.gapHeight),
                SizedBox(
                  width: context.deviceWidth,
                  height: context.buttonHeight,
                  child: CustomTextButton(
                    text: "CONTINUE",
                    onPressed: () {
                      String sentOtp = base64Decoder(widget.otp);
                      if (sentOtp == enteredOTP.text) {
                        Navigator.popAndPushNamed(
                          context,
                          Routes.resetPassword,
                          arguments: ResetPassword(
                            userName: widget.userName,
                          ),
                        );
                      } else {
                        ConstantWidgets.showAlert(
                          context,
                          "Invalid OTP",
                          StateType.error,
                        );
                        setState(() {
                          clearOtpField = true;
                        });
                      }
                    },
                  ),
                ),
                if (otpSent) ...[
                  SizedBox(height: context.gapHeight),
                  RichText(
                    text: TextSpan(
                        text: 'Resend OTP in',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: BrandingColors.textColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' $_timerCount',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: BrandingColors.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: ' sec',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: BrandingColors.textColor),
                          )
                        ]),
                  )
                ] else ...[
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      _bloc!.add(
                        ForgotPasswordEvent(
                          userName: widget.userName,
                        ),
                      );
                    },
                    child: Text(
                      "Resend",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            color: BrandingColors.textColor,
                          ),
                    ),
                  )
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
