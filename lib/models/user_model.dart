import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:paramotor/models/equipment_model.dart';

/// UserModel class that contains important information of the user.
class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;
  UserModel(
      {this.uid,
      this.email,
      this.password,
      this.displayName,
      this.age,
      this.isVerified});

  /// Converts info to a Map in Json format to send to Database.
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'age': age,
    };
  }

  /// Maps the retrieved data to the class UserModel.
  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"] as String,
        age = doc.data()!["age"] as int,
        displayName = doc.data()!["displayName"] as String;

  /// Updates specific fields and returns an instance with updated fields.
  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        age: age ?? this.age,
        isVerified: isVerified ?? this.isVerified);
  }
}
