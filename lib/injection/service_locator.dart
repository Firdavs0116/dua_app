import 'package:get_it/get_it.dart';
import 'package:my_dua_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_dua_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_dua_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void>init() async {

  // Cubit uchun
  sl.registerFactory(() => AuthCubit(loginUsecase: sl(), registerUsecase: sl()),);


  // Usecases 

  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()),);

  // repository 
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl())
  );
  

}