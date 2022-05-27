import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odc_game/constants/my_string.dart';
import 'package:odc_game/model/user_model.dart';
import 'package:odc_game/services/firestore_methods.dart';

import '../../model/game_room_model.dart';

class MainController extends GetxController {
  ///data hhhh
  var allUsersList = <UserModel>[].obs;
  GetStorage savedData = GetStorage();
  List idList = <String>[];
  UserModel? myData;
  String myUid = "";
  RxBool isThereGame = false.obs;
  final currentGame = Rxn<GameRoomModel>();
  RxString theWinner = "".obs;

  @override
  void onInit() async {
    myUid = savedData.read(KUid);
    getAllUsers();
    getMyData();
    listenGame();

    super.onInit();
  }

  ///get my data from firebase
  getMyData() {
    FireStoreMethods().users.doc(myUid).get().then((value) {
      myData = UserModel.fromMap(value);
      update();
    });
  }

  ///create game in firebase
  createGame({required UserModel friendData}) async {
    String _myUid = savedData.read(KUid);
    final snapShot =
        await FireStoreMethods().gameRooms.doc(friendData.uid).get();
    if (snapShot.exists) {
      Get.snackbar("in game", "this player in another game");
    } else {
      GameRoomModel gameRoomModel = GameRoomModel(
          firstPlayerId: _myUid,
          firstPlayerName: myData!.displayName!,
          secondPlayerId: friendData.uid!,
          secondPlayerName: friendData.displayName!,
          lastPlayerID: friendData.uid!,
          indexes: [],
          playerTurnName: myData!.displayName!);

      try {
        await FireStoreMethods()
            .gameRooms
            .doc(_myUid)
            .set(gameRoomModel.toMap(gameRoomModel));
        await FireStoreMethods()
            .gameRooms
            .doc(friendData.uid!)
            .set(gameRoomModel.toMap(gameRoomModel));
      } catch (e) {
        Get.snackbar("error", e.toString(),
            backgroundColor: Colors.red.shade300);
      }
    }
  }

  /// listen if there is a game  in firebase
  listenGame() {
    isThereGame.value = false;
    FireStoreMethods().gameRooms.doc(myUid).snapshots().listen((event) {
      if (event.exists) {
        currentGame.value = GameRoomModel.fromMap(event);
        isThereGame.value = true;
        update();
      } else {
        isThereGame.value = false;
      }
    });
  }

  bool listContainsAll(
    int a,
    int b,
    int c,
  ) {
    return currentGame.value!.indexes.contains(a) &&
        currentGame.value!.indexes.contains(b) &&
        currentGame.value!.indexes.contains(c);
  }

  ///function to check the winner

  checkTheWinner() {
    if (listContainsAll(0, 2, 3) ||
        listContainsAll(3, 4, 5) ||
        listContainsAll(6, 7, 8) ||
        listContainsAll(3, 4, 5) ||
        listContainsAll(0, 3, 6) ||
        listContainsAll(1, 4, 7) ||
        listContainsAll(2, 5, 8) ||
        listContainsAll(1, 4, 8) ||
        listContainsAll(2, 4, 6)) {
      if (currentGame.value!.firstPlayerId == myUid) {
        theWinner.value == currentGame.value!.firstPlayerName;
        update();
      } else {
        theWinner.value == currentGame.value!.secondPlayerName;
        update();
      }
    }
    print(theWinner.value);
  }

  /// add new move from player
  updateGameView({
    required int index,
    required String firstPlayerId,
    required String secondPlayerId,
    required String secondPlayerName,
    required List indexes,
  }) {
    try {
      if (indexes.contains(index) || currentGame.value!.lastPlayerID == myUid) {
        Get.snackbar("taken", "not your turn");
      } else {
        indexes.add(index);
        FireStoreMethods()
            .gameRooms
            .doc(currentGame.value!.firstPlayerId)
            .update({
          "indexes": indexes,
          "lastPlayerID": myUid,
          "playerTurnName": secondPlayerName
        });
        FireStoreMethods()
            .gameRooms
            .doc(currentGame.value!.secondPlayerId)
            .update({
          "indexes": indexes,
          "lastPlayerID": myUid,
          "lastPlayerName": secondPlayerName
        });
        isMyMove(index);}
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
    checkTheWinner();
  }

  /// end game
  endGame() async {
    await FireStoreMethods()
        .gameRooms
        .doc(currentGame.value!.firstPlayerId)
        .delete();
    await FireStoreMethods()
        .gameRooms
        .doc(currentGame.value!.secondPlayerId)
        .delete();
  }

  ///check who should make the next move
  bool isMyMove(int index) {
    if (myUid == currentGame.value!.firstPlayerId) {
      if (currentGame.value!.indexes.indexOf(0) == index ||
          currentGame.value!.indexes.indexOf(2) == index ||
          currentGame.value!.indexes.indexOf(4) == index ||
          currentGame.value!.indexes.indexOf(6) == index ||
          currentGame.value!.indexes.indexOf(8) == index) {
        return true;
      } else {
        return false;
      }
    } else {
      if (currentGame.value!.indexes.indexOf(1) == index ||
          currentGame.value!.indexes.indexOf(3) == index ||
          currentGame.value!.indexes.indexOf(5) == index ||
          currentGame.value!.indexes.indexOf(7) == index) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// get all players from firebase
  getAllUsers() async {
    FireStoreMethods().users.snapshots().listen((event) {
      allUsersList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        allUsersList.add(UserModel.fromMap(event.docs[i]));
      }
    });
  }
}
