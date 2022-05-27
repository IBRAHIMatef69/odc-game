import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? email;
   String? phoneNumber;
  String? uid;
  Timestamp? registerDate;  String? token;

  UserModel(
      this.displayName,
      this.uid,
      this.email,
       this.phoneNumber,this.registerDate    ,this.token,
       );

  Map<String, dynamic> toMap() {
    return {
      'displayName': this.displayName,
      'uid': this.uid,
      'email': this.email,
       'phoneNumber': this.phoneNumber,
      "registerDate":this.registerDate,      'token': this.token,
     };
  }

  factory UserModel.fromMap(map) {
    return UserModel(
      map['displayName'],
      map['uid'],
      map['email'],
      map['phoneNumber'],
      map['registerDate'],
      map['token'],
      );
  }
}
