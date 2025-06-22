import 'package:my_dua_app/features/language/domain/repositories/locale_repository.dart';

class SetLocaleUsecase {

  final LocaleRepository repository;
  SetLocaleUsecase(this.repository);

  Future<void> call(String localeCode) => repository.setLocale(localeCode);
}