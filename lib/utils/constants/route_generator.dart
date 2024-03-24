import 'package:flutter/material.dart';
import 'package:room_rental/screens/bill_detail_page.dart';
import 'package:room_rental/screens/camera_page.dart';
import 'package:room_rental/screens/change_password.dart';
import 'package:room_rental/screens/contract_details.dart';
import 'package:room_rental/screens/create_bill.dart';
import 'package:room_rental/screens/dashboard.dart';
import 'package:room_rental/screens/edit_personal_details.dart';
import 'package:room_rental/screens/edit_service_request.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/screens/languages.dart';
import 'package:room_rental/screens/new_service_request_page.dart';
import 'package:room_rental/screens/notifications.dart';
import 'package:room_rental/screens/payments.dart';
import 'package:room_rental/screens/personal_details.dart';
import 'package:room_rental/screens/reset_password_success.dart';
import 'package:room_rental/screens/services_page.dart';
import 'package:room_rental/screens/settings.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/screens/forgot_password.dart';
import 'package:room_rental/screens/reset_password.dart';
import 'package:room_rental/screens/signin.dart';
import 'package:room_rental/screens/verify_otp.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());

      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case Routes.verifyOTP:
        final args = settings.arguments as VerifyOTP;
        return MaterialPageRoute(
          builder: (_) => VerifyOTP(
            otp: args.otp,
            userName: args.userName,
          ),
        );

      case Routes.resetPassword:
        final args = settings.arguments as ResetPassword;
        return MaterialPageRoute(
          builder: (_) => ResetPassword(
            userName: args.userName,
          ),
        );
      case Routes.resetPasswordSuccessPage:
        final args = settings.arguments as ResetPasswordSuccessPage;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordSuccessPage(
            userName: args.userName,
            password: args.password,
          ),
        );

      case Routes.indexPage:
        return MaterialPageRoute(
          builder: (_) {
            final args = settings.arguments as IndexingPage?;
            return IndexingPage(
              selectedIndex: args?.selectedIndex ?? 0,
            );
          },
        );

      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());

      case Routes.notificationsPage:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());

      case Routes.languagesPage:
        return MaterialPageRoute(builder: (_) => const LanguagesPage());
      case Routes.paymentsPage:
        return MaterialPageRoute(builder: (_) => const PaymentsPage());
      case Routes.servicesPage:
        return MaterialPageRoute(builder: (_) => const ServicesPage());
      case Routes.settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case Routes.createBill:
        final args = settings.arguments as CreateBillPage;
        return MaterialPageRoute(
          builder: (_) => CreateBillPage(
            billType: args.billType,
            month: args.month,
            notGenProperties: args.notGenProperties,
          ),
        );

      case Routes.billDetailPage:
        final args = settings.arguments as BillDetailPage;
        return MaterialPageRoute(
          builder: (_) => BillDetailPage(
            billType: args.billType,
            bills: args.bills,
          ),
        );
      case Routes.editServiceRequest:
        final args = settings.arguments as EditServiceRequest;
        return MaterialPageRoute(
          builder: (_) => EditServiceRequest(
            data: args.data,
            readOnly: args.readOnly,
          ),
        );
      case Routes.createNewRequestPage:
        return MaterialPageRoute(builder: (_) => const NewRequestPage());

      case Routes.personalDetailsPage:
        return MaterialPageRoute(builder: (_) => const PersonalDetails());
      case Routes.editPersonalDetailsPage:
        return MaterialPageRoute(
          builder: (_) => const EditPersonalDetailsPage(),
        );
      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePassword(),
        );
      case Routes.contractDetailsPage:
        return MaterialPageRoute(
          builder: (_) => const ContractDetails(),
        );
      case Routes.cameraPage:
        final args = settings.arguments as CameraPage;
        return MaterialPageRoute(
          builder: (_) => CameraPage(
            cameras: args.cameras,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}
