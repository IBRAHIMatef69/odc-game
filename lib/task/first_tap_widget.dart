import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/task/auth_text_from_field.dart';
import 'package:odc_game/task/figma_task.dart';
import 'package:odc_game/task/mainButton.dart';
import 'package:odc_game/view/widgets/auth/auth_text_from_field.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

class FirstTapBarWidget extends StatelessWidget {
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE5E5E5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KTextUtils(
                text: "Ready to start trading with real money?",
                size: 16,
                color: GreenColor,
                fontWeight: FontWeight.w400,
                textDecoration: TextDecoration.none),
            SizedBox(
              height: 26,
            ),
            KTextUtils(
                text: "Log in",
                size: 18,
                color: GreenColor,
                fontWeight: FontWeight.w500,
                textDecoration: TextDecoration.none),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                KTextUtils(
                    text: "Don’t have an account? ",
                    size: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    textDecoration: TextDecoration.none),
                KTextUtils(
                    text: "Sign Up.",
                    size: 12,
                    color: GreenColor,
                    fontWeight: FontWeight.w400,
                    textDecoration: TextDecoration.none),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: Get.height * .1,
              width: Get.width,
              child: TextFromFieldWidget(
                  controller: controller1,
                  obscureText: false,
                  validator: (s) {
                    return null;
                  },
                  hintText: "Username or Email",
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: SizedBox()),
            ),
            Container(
              height: Get.height * .1,
              width: Get.width,
              child: TextFromFieldWidget(
                  controller: controller1,
                  obscureText: false,
                  validator: (s) {
                    return null;
                  },
                  hintText: "Password",
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: DISABLED,
                  )),
            ),
            KTextUtils(
                text: "Forgot your username/password?",
                size: 16,
                color: GreenColor,
                fontWeight: FontWeight.w400,
                textDecoration: TextDecoration.none),
            SizedBox(
              height: 40,
            ),
            Container(alignment: Alignment.center,
              child: MainButton(
                  onPressed: () {},
                  text: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: Get.width * .35 ,
                  buttonColor: GreenColor),
            )
          ],
        ),
      ),
    );
  }
}
