import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_locale_state.dart';

class ChangeLocaleCubit extends Cubit<Locale> {
  ChangeLocaleCubit() : super(const Locale('en', 'US'));

  void changeLocale(Locale newLocale) {
    emit(newLocale);
  }

}
