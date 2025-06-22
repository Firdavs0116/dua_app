import 'package:my_dua_app/features/language/data/locale_datasource.dart';

import '../../domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleDatasource localeDatasource;

  LocaleRepositoryImpl(this.localeDatasource);

  @override
  Future<String?> getSavedLocale() {
    return localeDatasource.getSavedLocale();
  }
  
  @override
  Future<void> setLocale(String localeCode) => localeDatasource.saveLocale(localeCode);
}
