import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/blocs/cubits/change_locale_cubit/change_locale_cubit.dart';
import 'package:room_rental/blocs/cubits/user_data/user_data_cubit.dart';
import 'package:room_rental/l10n/I10n.dart';

import 'package:room_rental/blocs/user_bloc/user_bloc_bloc.dart';
import 'package:room_rental/network/repo/user_repo.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/route_generator.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await Storage.getValue(StorageKeys.accessToken);
  bool isTknExpired = isTokenExpired(token);
  runApp(
    BlocProvider(
      create: (context) => ChangeLocaleCubit(),
      child: MyApp(
        isUserTokenExpired: isTknExpired,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.isUserTokenExpired,
  }) : super(key: key);
  final bool isUserTokenExpired;
  final RouteGenerator _router = RouteGenerator();
  final UserRepo userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userRepo),
        ),
        BlocProvider(
          create: (context) => ApplicationBloc(),
        ),
        BlocProvider(
          create: (context) => UserDataCubit(),
        ),
      ],
      child: BlocBuilder<ChangeLocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Room Rental',
            supportedLocales: L10n.all,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            onGenerateRoute: _router.generateRoute,
            initialRoute:
                (isUserTokenExpired) ? Routes.signIn : Routes.indexPage,
            theme: ThemeData(
              useMaterial3: true,
              dialogBackgroundColor: BrandingColors.backgroundColor,
              primaryColorLight: BrandingColors.backgroundColor,
              splashColor: BrandingColors.primaryColor,
              iconTheme:
                  const IconThemeData(color: BrandingColors.primaryColor),
              listTileTheme: ListTileThemeData(
                titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                subtitleTextStyle:
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: BrandingColors.backgroundColor,
                iconTheme: IconThemeData(
                  color: BrandingColors.primaryColor,
                ),
              ),
              textTheme: GoogleFonts.notoSansTextTheme(
                Theme.of(context).textTheme.copyWith(
                      labelMedium: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: BrandingColors.bodyContent,
                      ),
                      labelLarge: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: BrandingColors.bodyContent,
                      ),
                      headlineSmall: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: BrandingColors.bodyTitle,
                      ),
                    ),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: BrandingColors.primaryColor,
              ).copyWith(
                background: BrandingColors.backgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
