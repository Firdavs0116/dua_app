// Fayl: service_locator.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:my_dua_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:my_dua_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_dua_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_dua_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance; 

Future<void> init() async {
  // Firebase instance
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Remote datasource
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(
    loginUsecase: sl(),
    registerUsecase: sl(),
  ));
}
