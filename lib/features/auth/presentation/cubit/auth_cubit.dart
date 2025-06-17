import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_dua_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthCubit({required this.loginUsecase, required this.registerUsecase})
  : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try{
      final user = await loginUsecase(email, password);
      emit(AuthSuccess(user));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
  }

  void register(String email, String password) async {
    emit(AuthLoading());

    try{
      final user = await registerUsecase(email, password);
      emit(AuthSuccess(user));

    }catch(e){
      emit(AuthFailure(e.toString()));
    }
  }
}