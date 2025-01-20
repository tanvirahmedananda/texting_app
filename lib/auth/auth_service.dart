import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Future<bool> login(String email, String password)async{
   final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

   return credential.user!=null;

  }

  static Future<bool> register(String email, String password)async{
   final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

   return credential.user!=null;

  }

  static Future<void> logOut()=> _auth.signOut();
  //LOGS OUT USER
}