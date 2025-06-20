import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasource(this._firebaseAuth);

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