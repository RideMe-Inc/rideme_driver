abstract class LocalizationRepository {
  //change localization
  Future<bool> changeLocale(String localeName);

  //get current locale
  String getCurrentLocale();
}
