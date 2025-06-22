import 'package:my_dua_app/features/language/data/locale_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleDatasourceImpl  implements LocaleDatasource{
  final SharedPreferences prefs;
  LocaleDatasourceImpl(this.prefs);
  
  @override
  Future<String?> getSavedLocale() async {
    return prefs.getString("locale");
  }

  @override
  Future<void> saveLocale(String localeCode) async {
    await prefs.setString("locale", localeCode);
  }
}