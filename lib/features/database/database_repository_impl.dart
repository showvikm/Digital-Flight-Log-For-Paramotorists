import 'package:paramotor/models/user_model.dart';

import 'database_service.dart';
/// Class with two methods: saveUserData() to add the data to Firestore and
/// retrieveUserData() to retrieve the data from the database.
class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<List<UserModel>> retrieveUserData();
}
