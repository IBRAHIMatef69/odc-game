import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/constants/colors.dart';
import 'package:odc_game/controller/controller/auth_controller.dart';
import 'package:odc_game/controller/controller/main_controller.dart';
import 'package:odc_game/view/widgets/main_Widget/choose_user_widget.dart';
import 'package:odc_game/view/widgets/main_Widget/game_grid_view.dart';
import 'package:odc_game/view/widgets/main_Widget/player_Turn_widget.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

class MainScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * .07),
            Obx(() {
              return SizedBox(
                height: Get.height * .03,
                child: KTextUtils(
                    text: mainController.isThereGame.value
                        ? "playing with"
                        : "Users",
                    size: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.none),
              );
            }),
            Row(
              children: [
                Expanded(child: Container(child: ChooseUserWidget())),
                Container(
                  decoration: const BoxDecoration(
                      color: mainColor2,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(15))),
                  child: IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            onConfirm: () {
                              Get.back();
                            },
                            onCancel: () {
                              authController.signOutFromApp();
                              mainController.dispose();
                            },
                            title: "Logout",
                            textConfirm: "No",
                            middleText: "Are you sure to Logout...!",
                            confirmTextColor: Colors.white,
                            textCancel: "Yes",
                            buttonColor: mainColor2,
                            cancelTextColor: mainColor2,
                            backgroundColor: white);
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: mainColor3,
                      )),
                )
              ],
            ),
            SizedBox(height: Get.height * .02),
            GameGridView(),
            PlayerTurnWidget()
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        return mainController.isThereGame.value
            ? GestureDetector(
                onTap: () {
                  mainController.endGame();
                },
                child: Container(
                  height: Get.height * .06,
                  width: Get.width * .5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: mainColor2,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     mainColor2,
                    //     // Color(0xffcc6213),
                    //     // Color(0xffba0b08),
                    //     // Color(0xff931c04),
                    //     // Color(0xff3f0303),
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "End Game",
                      style: TextStyle(
                          fontSize: 22,
                          color: white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            : SizedBox();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
