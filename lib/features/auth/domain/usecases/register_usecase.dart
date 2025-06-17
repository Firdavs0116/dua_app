import 'package:my_dua_app/features/auth/domain/entities/user_entity.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserEntity> call(String email, String password){
    return repository.register(email, password);
  }
}