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
            : Center(
                child: KTextUtils(
                    text: "Add new game...",
                    size: 22,
                    color: black,
                    fontWeight: FontWeight.w800,
                    textDecoration: TextDecoration.none),
              );
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
                      ?   mainController.isMyMove(index).value
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
}
