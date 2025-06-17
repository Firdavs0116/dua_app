import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<void> call(String email, String password){
    return repository.logout();
  }
}