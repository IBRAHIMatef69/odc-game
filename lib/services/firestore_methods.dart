import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:odc_game/constants/my_string.dart';

class FireStoreMethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollectionKey);
  CollectionReference gameRooms =
      FirebaseFirestore.instance.collection(gameRoomsCollectionKey);
   CollectionReference playersScore =
      FirebaseFirestore.instance.collection(playersScoreCollectionKey);

  Future<void> insertUserInfoFireStorage(
    String displayName,
    email,
    uid,
    phoneNumber,
  ) async {
    var token = await FirebaseMessaging.instance.getToken();
    users.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
      "phoneNumber": phoneNumber,
      "registerDate": DateTime.now(),
    "token":token.toString()
    });
    return;
  }

////////////////////////////////

}
