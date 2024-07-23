import 'package:flutter/widgets.dart';
import 'package:rideme_driver/features/localization/domain/usecases/change_locale.dart';
import 'package:rideme_driver/features/localization/domain/usecases/get_current_locale.dart';

class LocaleProvider extends ChangeNotifier {
  final GetCurrentLocale getCurrentLocale;
  final ChangeLocale changeLocale;

  LocaleProvider({required this.getCurrentLocale, required this.changeLocale});

  //get

  String get locale => getCurrentLocale.call();

  //set
  changeLocal(String localeName) async {
    await changeLocale.call(localeName);
    notifyListeners();
  }

  //return language

  String getLanguageOfLocaleName(String localeName) {
    switch (localeName) {
      case 'en':
        return 'English';

      case 'fr':
        return 'French';

      default:
        return 'English';
    }
  }
}
