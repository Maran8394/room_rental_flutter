import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConstantWidgets {
  static Widget labelSizedBox(context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  static Widget gapSizedBox(context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  static Widget gapWidthSizedBox(context) =>
      SizedBox(width: MediaQuery.of(context).size.width * 0.05);

  static Future showAlert(context, message, StateType stateType) {
    String? showIcon;
    if (stateType == StateType.success) {
      showIcon = AssetsPath.sccessIcon;
    } else if (stateType == StateType.warning) {
      showIcon = AssetsPath.warningIcon;
    } else {
      showIcon = AssetsPath.failureIcon;
    }
    return showDialog(
      barrierDismissible: true,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          icon: SvgPicture.asset(
            showIcon!,
            height: context.deviceHeight / 14,
            width: context.deviceWidth / 10,
          ),

          title: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          titlePadding: const EdgeInsets.only(
            top: 0,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          actionsAlignment: MainAxisAlignment.center,

          // actions: [
          //   TextButton(
          //     child: const Text("OK"),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  static errorShowToaster(context, String message) => showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        CustomSnackBar.error(message: message),
      );
}
