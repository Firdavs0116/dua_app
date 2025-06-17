import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasourse {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourse(this._firebaseAuth);

  Future<User> login(String email, String password) async{
    final result  = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user!;
  }
  Future<User> register(String email, String password) async{
    final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user!;
  }

  void logout(){
    _firebaseAuth.signOut();
  }

  User? getCurrentUser() => _firebaseAuth.currentUser;
}