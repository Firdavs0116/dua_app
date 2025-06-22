import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/language/domain/usecases/get_locale_usecase.dart';
import 'package:my_dua_app/features/language/domain/usecases/set_locale_usecase.dart';

class LocaleCubit extends Cubit<Locale>{
  final GetLocaleUsecase getUsecase;
  final SetLocaleUsecase setlocale;

  
  LocaleCubit({required this.getUsecase, required this.setlocale}): super(const Locale("en")){
    loadSavedLocale();
  }

  void loadSavedLocale() async {
    final code = await getUsecase();
    if (code != null){
      emit(Locale(code));
    }
  }

  void changeLocale(String code) async {
    await setlocale(code);
    emit(Locale(code));
  }
}