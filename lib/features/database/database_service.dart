import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paramotor/models/user_model.dart';


/// DatabaseService class handles all Cloud Firestore Logic.
class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
    /// [addUserData] creates a collection called Users and then assign the
    /// uid as a documentd id an use the set() method to add the userData
    /// under the document.
    Future addUserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }
    /// [retrieveUserData] uses get() method to retrieve all the documents
    /// inside the Users collection and then we use map to return a list of type
    /// USerModel that will contain all the data. We also create a method called
    /// [retrieveUserName] to retrieve the displayName of the user.
    Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
    }

    Future<String?> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!["displayName"] as String;
    }
}
