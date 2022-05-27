import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/constants/colors.dart';
import 'package:odc_game/controller/controller/main_controller.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

class ChooseUserWidget extends StatelessWidget {
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mainController.myData.value!=null
          ? SizedBox(
              height: Get.height * .05,
              child: mainController.isThereGame.value
                  ?mainController.friendScore.value==null?SizedBox(): Row(                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                        Hero(
                          tag: "d",
                          child: buildContainer(
                              () => null,
                              mainController.currentGame.value!.firstPlayerId ==
                                      mainController.myUid
                                  ? mainController
                                      .currentGame.value!.secondPlayerName
                                  : mainController
                                      .currentGame.value!.firstPlayerName),
                        ),
                        Column(
                          children: [
                            KTextUtils(
                                text: "Score",
                                size: 15,
                                color: mainColor2,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                            KTextUtils(
                                text: mainController.friendScore.value!.score
                                    .toString(),
                                size: 15,
                                color: mainColor2,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                          ],
                        ),
                        Column(
                          children: [
                            KTextUtils(
                                text: "played games",
                                size: 15,
                                color: mainColor2,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                            KTextUtils(
                                text: mainController
                                    .friendScore.value!.gamesNumber
                                    .toString(),
                                size: 15,
                                color: mainColor2,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                          ],
                        ),
                      ],
                    )
                  : mainController.myData.value == null
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Hero(
                              tag: "d",
                              child: buildContainer(() => null,
                                  mainController.myData.value!.displayName!),
                            ),
                            Column(
                              children: [
                                KTextUtils(
                                    text: "Score",
                                    size: 15,
                                    color: mainColor2,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                                KTextUtils(
                                    text: mainController
                                        .myScoreData.value!.score.round()
                                        .toString(),
                                    size: 15,
                                    color: mainColor2,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                              ],
                            ),
                            Column(
                              children: [
                                KTextUtils(
                                    text: "played games",
                                    size: 15,
                                    color: mainColor2,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                                KTextUtils(
                                    text: mainController
                                        .myScoreData.value!.gamesNumber.round()
                                        .toString(),
                                    size: 15,
                                    color: mainColor2,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                              ],
                            ),
                          ],
                        ),
            )
          : SizedBox();
    });
  }

  Widget buildContainer(Function() function, String name) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: mainColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: mainColor4)),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: Get.width * .04,
              child: Image.asset("assets/gamer.png"),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: Get.width * .04,
                color: mainColor4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
