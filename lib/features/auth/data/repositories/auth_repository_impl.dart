import 'package:my_dua_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:my_dua_app/features/auth/data/models/user_model.dart';
import 'package:my_dua_app/features/auth/domain/entities/user_entity.dart';
import 'package:my_dua_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDatasource.getCurrentUser();
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remoteDatasource.login(email, password);
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> logout() async {
    remoteDatasource.logout();
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await remoteDatasource.register(email, password);
    return UserModel.fromFirebaseUser(user);
  }
  
}