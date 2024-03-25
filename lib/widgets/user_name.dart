import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/cubits/user_data/user_data_cubit.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserData) {
          String? fullName = state.fullName;
          return Text(
            fullName != null ? "Hi $fullName!" : "Hi there!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: BrandingColors.titleColor,
                  fontWeight: FontWeight.bold,
                ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
