import 'package:cloud_firestore/cloud_firestore.dart';

class UserReminders{
  String? rname;
  String? rdescription;
  UserReminders({this.rname, this.rdescription});

  /// Converts info to a Map in Json format to send to Database.
  Map<String, dynamic> toMap() {
    return {
      'rname': rname,
      'rdescription': rdescription,
    };
  }

  /// Maps the retrieved data to the class UserReminders.
  UserReminders.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : rname = doc.data()!['rname'] as String,
        rdescription = doc.data()!['rdescription'] as String;

  /// Updates specific fields and returns an instance with updated fields.
  UserReminders copyWith({
    String? rname,
    String? rdescription,
  }) {
    return UserReminders(
        rname: rname ?? this.rname,
        rdescription: rdescription ?? this.rdescription
    );
  }

}