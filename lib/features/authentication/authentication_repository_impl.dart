import 'package:firebase_auth/firebase_auth.dart';
import 'package:paramotor/features/authentication/authenticate_service.dart';
import 'package:paramotor/features/database/database_service.dart';

import '../../models/user_model.dart';

/// The repository class for Authentication will act as a layer above
/// the service class. So, here we have normal operations regarding
/// authentication.
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationService service = AuthenticationService();
  DatabaseService dbService = DatabaseService();
  /// Acquire the current user.
  @override
  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }
  /// Sign up method
  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
  /// SignIn method
  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
  /// signOut method
  @override
  Future<void> signOut() {
    return service.signOut();
  }
  /// Acquire the username of the user.
  @override
  Future<String?> retrieveUserName(UserModel user) {
    return dbService.retrieveUserName(user);
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
  Future<String?> retrieveUserName(UserModel user);
}
