import 'package:my_dua_app/features/auth/data/datasources/auth_remote_datasourse.dart';
import 'package:my_dua_app/features/auth/data/models/user_model.dart';
import 'package:my_dua_app/features/auth/domain/entities/user_entity.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasourse remoteDatasourse;

  AuthRepositoryImpl(this.remoteDatasourse);

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDatasourse.getCurrentUser();
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remoteDatasourse.login(email, password);
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> logout() async {
    remoteDatasourse.logout();
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await remoteDatasourse.register(email, password);
    return UserModel.fromFirebaseUser(user);
  }
  
}