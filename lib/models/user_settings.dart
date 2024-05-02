import 'package:cloud_firestore/cloud_firestore.dart';

/// UserSettings class that contains important information of the user.
class UserSettings {
  int? licenseDefaultTime;
  int? gasDefaultTime;
  int? parachuteLife;
  int? engineLife;
  int? motorLife;
  UserSettings(
      {this.licenseDefaultTime,
      this.gasDefaultTime,
      this.parachuteLife,
      this.engineLife,
      this.motorLife});

  /// Converts info to a Map in Json format to send to Database.
  Map<String, dynamic> toMap() {
    return {
      'LicenseDefaultTime': licenseDefaultTime,
      'GasDefaultTime': gasDefaultTime,
      'ParachuteLife': parachuteLife,
      'EngineLife': engineLife,
      'MotorLife': motorLife,
    };
  }

  /// Maps the retrieved data to the class UserSettings.
  UserSettings.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : licenseDefaultTime = doc.data()!["LicenseDefaultTime"] as int,
        gasDefaultTime = doc.data()!["GasDefaultTime"] as int,
        parachuteLife = doc.data()!["ParachuteLife"] as int,
        engineLife = doc.data()!["EngineLife"] as int,
        motorLife = doc.data()!["MotorLife"] as int;

  /// Updates specific fields and returns an instance with updated fields.
  UserSettings copyWith({
    int? licenseDefaultTime,
    int? gasDefaultTime,
    int? parachuteLife,
    int? engineLife,
    int? motorLife,
  }) {
    return UserSettings(
        licenseDefaultTime: licenseDefaultTime ?? this.licenseDefaultTime,
        gasDefaultTime: gasDefaultTime ?? this.gasDefaultTime,
        parachuteLife: parachuteLife ?? this.parachuteLife,
        engineLife: engineLife ?? this.engineLife,
        motorLife: motorLife ?? this.motorLife);
  }
}
