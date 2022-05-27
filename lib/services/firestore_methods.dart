import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odc_game/constants/my_string.dart';

class FireStoreMethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollectionKey);
  CollectionReference gameRooms =
      FirebaseFirestore.instance.collection(gameRoomsCollectionKey);
  CollectionReference statusCollection =
      FirebaseFirestore.instance.collection(statusCollectionKey);

  Future<void> insertUserInfoFireStorage(
      String displayName, email, uid, phoneNumber, ) async {
    users.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
       "phoneNumber": phoneNumber,
      "registerDate": DateTime.now(),
     });
    return;
  }

////////////////////////////////


}
