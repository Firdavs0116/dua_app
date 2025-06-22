import 'package:my_dua_app/features/language/domain/repositories/locale_repository.dart';

class GetLocaleUsecase {
  final LocaleRepository repository;
  GetLocaleUsecase(this.repository);

  Future<String?> call() => repository.getSavedLocale();
  
}