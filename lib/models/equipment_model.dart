import 'package:cloud_firestore/cloud_firestore.dart';
/// Equipment model contains important information about the equipment lifespan
///
class EqModel{
  int? motor;
  int? wings;
  int? fuel;
  EqModel({this.motor, this.wings, this.fuel});
  /// Converts info to a Map in Json format to send to Database.
  Map<String, dynamic> toMap(){
    return {
      'motor': motor,
      'wings': wings,
      'fuel': fuel,
    };
  }
  /// Maps the retrieved data to the class UserModel.
  EqModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : motor = doc.data()!["motor"] as int,
        wings = doc.data()!["wings"] as int,
        fuel = doc.data()!["fuel"] as int;

  /// Updates specific fields and returns an instance with updated fields.
  EqModel copyWith({
    int? motor,
    int? wings,
    int? fuel,
  }) {
    return EqModel(
        motor: motor ?? this.motor,
        wings: wings ?? this.wings,
        fuel: fuel ?? this.fuel,
    );
  }
}

