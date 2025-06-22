import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_dua_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:my_dua_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_dua_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_dua_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:my_dua_app/features/language/data/locale_datasource.dart';
import 'package:my_dua_app/features/language/data/locale_datasource_impl.dart';
import 'package:my_dua_app/features/language/data/repository/locale_repo_impl.dart';
import 'package:my_dua_app/features/language/domain/repositories/locale_repository.dart';
import 'package:my_dua_app/features/language/domain/usecases/get_locale_usecase.dart';
import 'package:my_dua_app/features/language/domain/usecases/set_locale_usecase.dart';
import 'package:my_dua_app/features/language/presentation/cubit/locale_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Auth
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerFactory(() => AuthCubit(
        loginUsecase: sl(),
        registerUsecase: sl(),
      ));

  // Language
  sl.registerLazySingleton<LocaleDatasource>(() => LocaleDatasourceImpl(sl()));
  sl.registerLazySingleton<LocaleRepository>(() => LocaleRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetLocaleUsecase(sl()));
  sl.registerLazySingleton(() => SetLocaleUsecase(sl()));
  sl.registerFactory(() => LocaleCubit(
        getUsecase: sl(),
        setlocale: sl(),
      ));
}
