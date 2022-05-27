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
    theWinner.value = "";

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
          playerTurnName: myData!.displayName!,
          secondPlayerMoves: [],
          firstPlayerMoves: []);

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
        checkTheWinner();
        isThereGame.value = true;
        update();
      } else {
        isThereGame.value = false;
        theWinner.value = "";
      }
    });
  }

  ///function to check the winner

  checkTheWinner() {
    if (currentGame.value!.firstPlayerMoves.containsAll(0, 1, 2) ||
        currentGame.value!.firstPlayerMoves.containsAll(3, 4, 5) ||
        currentGame.value!.firstPlayerMoves.containsAll(6, 7, 8) ||
        currentGame.value!.firstPlayerMoves.containsAll(3, 4, 5) ||
        currentGame.value!.firstPlayerMoves.containsAll(0, 3, 6) ||
        currentGame.value!.firstPlayerMoves.containsAll(1, 4, 7) ||
        currentGame.value!.firstPlayerMoves.containsAll(2, 5, 8) ||
        currentGame.value!.firstPlayerMoves.containsAll(1, 4, 8) ||
        currentGame.value!.firstPlayerMoves.containsAll(2, 4, 6)) {
      theWinner.value = "the winner is ${currentGame.value!.firstPlayerName}";
      Get.snackbar("winner", theWinner.value);

      update();
    } else if (currentGame.value!.secondPlayerMoves.containsAll(0, 1, 2) ||
        currentGame.value!.secondPlayerMoves.containsAll(3, 4, 5) ||
        currentGame.value!.secondPlayerMoves.containsAll(6, 7, 8) ||
        currentGame.value!.secondPlayerMoves.containsAll(3, 4, 5) ||
        currentGame.value!.secondPlayerMoves.containsAll(0, 3, 6) ||
        currentGame.value!.secondPlayerMoves.containsAll(1, 4, 7) ||
        currentGame.value!.secondPlayerMoves.containsAll(2, 5, 8) ||
        currentGame.value!.secondPlayerMoves.containsAll(1, 4, 8) ||
        currentGame.value!.secondPlayerMoves.containsAll(2, 4, 6)) {
      theWinner.value = "the winner is ${currentGame.value!.secondPlayerName}";
      Get.snackbar("winner", theWinner.value);
      update();
    }
  }

  /// add new move from player
  updateGameView({
    required int index,
    required String firstPlayerId,
    required String secondPlayerId,
    required String secondPlayerName,
    required List indexes,
  }) async {
    try {
      if (theWinner.value == "") {
        if (indexes.contains(index) ||
            currentGame.value!.lastPlayerID == myUid) {
          Get.snackbar("taken", "not your turn");
        } else {
          indexes.add(index);
          await FireStoreMethods()
              .gameRooms
              .doc(currentGame.value!.firstPlayerId)
              .update({
            "indexes": indexes,
            "lastPlayerID": myUid,
            "playerTurnName": secondPlayerName
          });
          await FireStoreMethods()
              .gameRooms
              .doc(currentGame.value!.secondPlayerId)
              .update({
            "indexes": indexes,
            "lastPlayerID": myUid,
            "lastPlayerName": secondPlayerName
          });
          if (currentGame.value!.firstPlayerId == myUid) {
            List _list = currentGame.value!.firstPlayerMoves;
            _list.add(index);

            await FireStoreMethods()
                .gameRooms
                .doc(currentGame.value!.firstPlayerId)
                .update({
              "firstPlayerMoves": _list,
            });
            await FireStoreMethods()
                .gameRooms
                .doc(currentGame.value!.secondPlayerId)
                .update({
              "firstPlayerMoves": _list,
            });
          } else if (currentGame.value!.secondPlayerId == myUid) {
            List _list2 = currentGame.value!.secondPlayerMoves;
            _list2.add(index);
            await FireStoreMethods()
                .gameRooms
                .doc(currentGame.value!.secondPlayerId)
                .update({
              "secondPlayerMoves": _list2,
            });
            await FireStoreMethods()
                .gameRooms
                .doc(currentGame.value!.firstPlayerId)
                .update({
              "secondPlayerMoves": _list2,
            });
          }
        }
      } else {
        Get.snackbar("start new game", theWinner.value);
      }
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
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
        .delete()
        .then((value) => theWinner.value = "");
  }

  ///check who should make the next move
  RxBool isMyMove(int index) {
    if (myUid == currentGame.value!.firstPlayerId) {
      if (currentGame.value!.indexes.containsAt(index, 0) ||
          currentGame.value!.indexes.containsAt(index, 2) ||
          currentGame.value!.indexes.containsAt(index, 4) ||
          currentGame.value!.indexes.containsAt(index, 6) ||
          currentGame.value!.indexes.containsAt(index, 8)) {
        return true.obs;
      } else {
        return false.obs;
      }
    } else {
      if (currentGame.value!.indexes.containsAt(index, 1) ||
          currentGame.value!.indexes.containsAt(index, 3) ||
          currentGame.value!.indexes.containsAt(index, 5) ||
          currentGame.value!.indexes.containsAt(index, 7)) {
        return true.obs;
      } else {
        return false.obs;
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

///  extension to check if the element exist at  this index

extension ListExtensions<T> on List<T> {
  bool containsAt(T value, int index) {
    assert(this != null);
    return index >= 0 && this.length > index && this[index] == value;
  }
}

///  extension to check if the 3 element  exists in the list
extension ContainsAll<T> on List<T> {
  bool containsAll(int a,
      int b,
      int c,) {
    if (contains(a) && contains(b) && contains(c)) {
      return true;
    } else {
      return false;
    }
  }
}
