import 'package:firebase_auth/firebase_auth.dart';
import 'package:paramotor/models/user_model.dart';

/// Contains all relevant Firebase Authentication functions.
class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  /// Using [authStateChanges] which will keep listening for any change
  /// regarding the authentication state of the user. If the user is not
  /// null, then we return an instance of UserModel with a valid userId,
  /// else we return an instance of UserModel with the string uid which means
  /// that the user is not logged in.
  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return  UserModel(uid: "uid");
      }
    });
  }
  /// signup(): Call createUserWithEmailAndPassword() to create a new
  /// user in the Firebase authentication console, we also call
  /// verifyEmail() which will validate the email that the user added
  /// in the signup form.
  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user.email!,password: user.password!);
          await verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
  /// Calls signInWithEmailAndPassword() which will sign in the user or
  /// return an error if anything happens. I.e. if the email is not authenticated
  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
  /// Send verification email to the user.
  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }
  /// Sign user out.
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
