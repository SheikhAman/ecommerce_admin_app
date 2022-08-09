import 'package:ecom_day_42/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth
      .instance; // singelton object(pass verify, registration,login etc korar jonno
  static User? get user => _auth.currentUser;

  static Future<bool> login(String email, String password) async {
    //  signIn successfull holee user er info gulo pabo
    // credential amake uid dei
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

// DBHelper er isAdmin method call korlam jeta return kore Future<bool>
    return DBHelper.isAdmin(credential.user!.uid);
  }

  static Future<void> logout() =>
      _auth.signOut(); // signout ba logout korar jonno

}
