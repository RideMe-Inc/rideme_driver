import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalizationLocalDataSource {
  //change locale

  Future<bool> changeLocale(String localeName);

  //get current locale

  String getCurrentLocale();
}

class LocalizationLocalDataSourceImpl implements LocalizationLocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalizationLocalDataSourceImpl({required this.sharedPreferences});

  final String localCache = 'LOCALE_CACHE';

  @override
  Future<bool> changeLocale(String localeName) async {
    return await sharedPreferences.setString(localCache, localeName);
  }

  @override
  String getCurrentLocale() {
    return sharedPreferences.getString(localCache) ?? 'en';
  }
}
