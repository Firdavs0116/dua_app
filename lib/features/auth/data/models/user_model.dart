import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_dua_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.uid, required super.email});

  factory UserModel.fromFirebaseUser(User user){
    return UserModel(
      uid: user.uid, 
      email: user.email ?? " ");
  }
}