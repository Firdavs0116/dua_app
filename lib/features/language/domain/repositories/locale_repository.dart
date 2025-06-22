abstract class LocaleRepository {
  Future<String?> getSavedLocale();
  Future<void> setLocale(String localeCode);
}