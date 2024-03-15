import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/cubits/change_locale_cubit/change_locale_cubit.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackButton(color: BrandingColors.primaryColor),
        title: Text(
          AppLocalizations.of(context)!.languages,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Container(
            decoration: BoxDecoration(
              color: BrandingColors.cardBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<ChangeLocaleCubit, Locale>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      selected: state.toLanguageTag() == "en",
                      title: const Text("English"),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      onTap: () {
                        onLanguageChange(
                          langCode: "en",
                          langName: "English",
                        );
                      },
                    ),
                    ListTile(
                      selected: state.toLanguageTag() == "zh",
                      title: const Text("Chinese"),
                      onTap: () {
                        onLanguageChange(
                          langCode: "zh",
                          langName: "Chinese",
                        );
                      },
                    ),
                    ListTile(
                      selected: state.toLanguageTag() == "zh-HK",
                      title: const Text("Traditional Chinese"),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      onTap: () {
                        onLanguageChange(
                          langCode: "zh",
                          countryCode: "HK",
                          langName: "Traditional Chinese",
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onLanguageChange({
    required String langCode,
    required String langName,
    String? countryCode,
  }) {
    context
        .read<ChangeLocaleCubit>()
        .changeLocale(Locale(langCode, countryCode));
    ConstantWidgets.showAlert(
      context,
      "Languange changed to $langName",
      StateType.success,
    );
  }
}
