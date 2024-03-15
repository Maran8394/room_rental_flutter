// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';

import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';

import '../widgets/progress_indicator.dart';

class ResetPasswordSuccessPage extends StatefulWidget {
  final String userName;
  final String password;
  const ResetPasswordSuccessPage({
    Key? key,
    required this.userName,
    required this.password,
  }) : super(key: key);

  @override
  State<ResetPasswordSuccessPage> createState() =>
      _ResetPasswordSuccessPageState();
}

class _ResetPasswordSuccessPageState extends State<ResetPasswordSuccessPage> {
  UserBloc? _bloc;
  ProgressDialog? dialog;
  bool ableToBack = false;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (val) async {
        _bloc!.add(
          SigninEvent(
            userName: widget.userName,
            password: widget.password,
          ),
        );
      },
      child: Scaffold(
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
              setState(() {
                ableToBack = true;
              });
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.indexPage,
                (route) => false,
                arguments: const IndexingPage(
                  selectedIndex: 1,
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
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 3),
                  SvgPicture.asset(
                    AssetsPath.sccessIcon,
                    height: context.deviceHeight / 6,
                  ),
                  SizedBox(height: context.gapHeight),
                  Center(
                    child: Text(
                      "Your Password has been successfully reset!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: BrandingColors.bodyTitle,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _bloc!.add(
                          SigninEvent(
                            userName: widget.userName,
                            password: widget.password,
                          ),
                        );
                      },
                      child: Text(
                        "Back to Home",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: BrandingColors.labelColor,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
