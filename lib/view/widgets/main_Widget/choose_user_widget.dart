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
      return mainController.allUsersList.isNotEmpty
          ? SizedBox(
              height: Get.height * .05,
              child: mainController.isThereGame.value
                  ? Row(
                      children: [
                        Hero(
                          tag: mainController
                              .currentGame.value!.secondPlayerName,
                          child: buildContainer(
                              () => null,
                              mainController.currentGame.value!.firstPlayerId ==
                                      mainController.myUid
                                  ? mainController
                                      .currentGame.value!.secondPlayerName
                                  : mainController
                                      .currentGame.value!.firstPlayerName),
                        )
                      ],
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return mainController.myUid !=
                                mainController.allUsersList[index].uid!
                            ? Hero(
                                tag: mainController
                                    .allUsersList[index].displayName!,
                                child: buildContainer(
                                  () {
                                    mainController.createGame(
                                        friendData:
                                            mainController.allUsersList[index]);
                                  },
                                  mainController
                                      .allUsersList[index].displayName!,
                                ),
                              )
                            : SizedBox();
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 8,
                        );
                      },
                      itemCount: mainController.allUsersList.length),
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
