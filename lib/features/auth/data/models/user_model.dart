import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_dua_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required String uid, required String email})
    : super(uid: uid, email: email);

  factory UserModel.fromFirebaseUser(User user){
    return UserModel(uid: user.uid, email: user.email ?? " ");
  }
}