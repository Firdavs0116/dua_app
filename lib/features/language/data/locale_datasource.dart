abstract class LocaleDatasource {
  Future<String?> getSavedLocale();
  Future<void> saveLocale(String localeCode);
}