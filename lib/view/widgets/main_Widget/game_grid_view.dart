import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/constants/colors.dart';
import 'package:odc_game/controller/controller/main_controller.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

class GameGridView extends StatelessWidget {
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .5,
      width: Get.width,
      child: Obx(() {
        return mainController.isThereGame.value == true
            ? GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3, mainAxisSpacing: 5, crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return gridViewItem(() {
              mainController.updateGameView(
                  index: index,
                  firstPlayerId:
                  mainController.currentGame.value!.firstPlayerId,
                  secondPlayerId:
                  mainController.currentGame.value!.secondPlayerId,
                  indexes: mainController.currentGame.value!.indexes,
                  secondPlayerName:
                  mainController.currentGame.value!.secondPlayerName);
            }, index);
          },
        )
            : allPlayersListView();
      }),
    );
  }

  Widget gridViewItem(Function() function, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Obx(() {
          return Center(
            child: Text(
              mainController.currentGame.value!.indexes == []
                  ? ""
                  : mainController.currentGame.value!.indexes.contains(index)
                  ? mainController
                  .isMyMove(index)
                  .value
                  ? "x"
                  : "o"
                  : "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget allPlayersListView() {
    return Container(
      child: Obx(() {
        return mainController.allUsersScoreList.isEmpty
            ? SizedBox()
            : ListView.separated(
          shrinkWrap: true,
          itemCount: mainController.allUsersScoreList.length,
          itemBuilder: (context, index) {
            return mainController.allUsersScoreList[index].uid ==
                mainController.myUid
                ? SizedBox()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2,
                  child: CircleAvatar(
                    maxRadius: Get.width * .055,
                    child: Image.asset("assets/gamer.png"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(flex: 3,
                   child: Text(
                    mainController.allUsersScoreList[index].name,
                    style: TextStyle(
                      fontSize: Get.width * .055,
                      color: mainColor4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(flex: 5,
                  child: Center(
                    child: KTextUtils(
                        text: mainController
                            .allUsersScoreList[index].score.round()
                            .toString(),
                        size: Get.width * .04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textDecoration: TextDecoration.underline),
                  ),
                ),
                Expanded(flex: 3,
                  child: MaterialButton(
                      onPressed: () {
                        mainController.createGame(
                            friendName: mainController
                                .allUsersScoreList[index].name,
                            friendUid: mainController
                                .allUsersScoreList[index].uid);
                      },
                      color: mainColor2,
                      child: Text(
                        "Play",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ],
            );
            // ListTile(
            //         leading: CircleAvatar(
            //           maxRadius: Get.width * .055,
            //           child: Image.asset("assets/gamer.png"),
            //         ),
            //         title: Text(
            //           mainController.allUsersScoreList[index].name,
            //           style: TextStyle(
            //             fontSize: Get.width * .055,
            //             color: mainColor4,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         trailing: MaterialButton(
            //             onPressed: () {
            //               mainController.createGame(
            //                   friendName: mainController
            //                       .allUsersScoreList[index].name,
            //                   friendUid: mainController
            //                       .allUsersScoreList[index].uid);
            //             },
            //             color: mainColor2,
            //             child: Text(
            //               "Play",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(20))),
            //       );
          }, separatorBuilder: (BuildContext context, int index) {
          return const Divider(color: Colors.grey,thickness: .5,);
        },);
      }),
    );
  }
}
