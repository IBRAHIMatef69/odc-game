import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/task/mainButton.dart';
import 'package:odc_game/task/task_controller.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final controllerZ = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              buildSizedBox(Get.height * .13),
              Container(
                alignment: Alignment.center,
                child: Image.asset("assets/Group 249.png"),
              ),
              buildSizedBox(Get.height * .06),
              // Container(width: Get.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(18),
              //       color: Color(0xffF3F9FF)),
              //   height: Get.height * .05,
              //   child: TabBar(
              //     indicatorColor: Colors.transparent,
              //     tabs: [
              //       MainButton(
              //         onPressed: () {},
              //         text: Text(
              //           "Live",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 16,
              //               color: Colors.white),
              //         ),
              //         width: Get.width * .42,
              //         buttonColor: Colors.green,
              //       ),
              //       MainButton(
              //         onPressed: () {},
              //         text: Text(
              //           "Paper Trading",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 16,
              //               color: Color(0xff4EA831)),
              //         ),
              //         width: Get.width * .42,
              //         buttonColor: Color(0xffF3F9FF),
              //       ),
              //     ],
              //   ),
              // ),
              // Center(
              //   child: GetBuilder<TaskController>(
              //     builder: (_) {
              //       return Container(width: Get.width,
              //
              //           child: TabBarView(children: controllerZ.tabScreens));
              //     },
              //   ),
              // )
              Container(
                height: Get.height * .04,
                color: Color(0xffF3F9FF),
                child: GetBuilder<TaskController>(
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainButton(
                          onPressed: () {
                            controllerZ.pageController.jumpToPage(0);
                            controllerZ.pageTapped(0);
                          },
                          text: Text(
                            "Live",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: controllerZ.pageViewSelectedIndex == 0
                                    ? Color(0xffF3F9FF)
                                    : Color(0xff4EA831)),
                          ),
                          width: Get.width * .42,
                          buttonColor: controllerZ.pageViewSelectedIndex == 0
                              ? Color(0xff4EA831)
                              : Color(0xffF3F9FF),
                        ),
                        MainButton(
                          onPressed: () {
                            controllerZ.pageController.jumpToPage(1);

                            controllerZ.pageTapped(1);
                          },
                          text: Text(
                            "Paper Trading",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: controllerZ.pageViewSelectedIndex == 0
                                    ? Color(0xff4EA831)
                                    : Color(0xffF3F9FF)),
                          ),
                          width: Get.width * .42,
                          buttonColor: controllerZ.pageViewSelectedIndex == 0
                              ? Color(0xffF3F9FF)
                              : Color(0xff4EA831),
                        ),
                      ],
                    );
                  },
                ),
              ),
              buildSizedBox(Get.height * .025),
              Expanded(
                child: GetBuilder<TaskController>(
                  builder: (_) {
                    return PageView.builder(
                      controller: controllerZ.pageController,
                      onPageChanged: controllerZ.pageTapped,
                      itemBuilder: (context, index) {
                        return controllerZ.tabScreens[index];
                      },
                      itemCount: controllerZ.tabScreens.length,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox(double height) => SizedBox(height: height);
}
const Color GreenColor=Color(0xff4EA831);