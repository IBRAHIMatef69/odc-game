import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/constants/colors.dart';
import 'package:odc_game/controller/controller/main_controller.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

class PlayerTurnWidget extends StatelessWidget {
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Obx(() {

        return
          mainController.theWinner.value ==""?
          mainController.isThereGame.value
            ? mainController.currentGame.value!.lastPlayerID !=
                    mainController.myUid
                ? KTextUtils(
                    text: "it's your turn",
                    size: Get.width * .07,
                    color: mainColor2,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.none)
                : KTextUtils(
                    text: "it's " +
                        mainController.currentGame.value!.playerTurnName +
                        " turn",
                    size: Get.width * .07,
                    color: mainColor2,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.none)
            : SizedBox():
          KTextUtils(
              text: mainController.theWinner.toString(),
              size: Get.width * .07,
              color: mainColor2,
              fontWeight: FontWeight.bold,
              textDecoration: TextDecoration.none);
      }),
    );
  }
}
