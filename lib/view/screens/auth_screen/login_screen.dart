import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/controller/controller/auth_controller.dart';
import 'package:odc_game/routes/routes.dart';
import 'package:odc_game/view/widgets/utils_widgets/text_utils.dart';

import '../../../constants/colors.dart';
import '../../../constants/my_string.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/utils_widgets/icon_botton_utils.dart';

class LoginScreen extends StatelessWidget {
  final form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // afroto

              SizedBox(
                height: 15,
              ),
              // النص
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                         SizedBox(
                      width: Get.width * .05,
                    ),  KTextUtils(
                      text: "Start a new Game",
                      size: 17,
                      color: black,
                      fontWeight: FontWeight.normal,
                      textDecoration: TextDecoration.none,
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .1,
              ),
              // نص ال login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KTextUtils(
                        text: "Login",
                        size: 30,
                        color: black,
                        fontWeight: FontWeight.bold,
                        textDecoration: TextDecoration.none,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthTextFromField(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: black,
                            ),
                            suffixIcon: Text(""),
                            controller: emailController,
                            obscureText: false,
                            validator: (value) {
                              if (!RegExp(validationEmail).hasMatch(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Email',
                            textInputType: TextInputType.text,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthTextFromField(
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.visibility();
                              },
                              icon: controller.isVisibilty
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              color: black,
                            ),
                            controller: passwordController,
                            obscureText: controller.isVisibilty ? false : true,
                            validator: (value) {
                              if (value.toString().length < 6) {
                                return "Password is too short";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Password',
                            textInputType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgotPassword);
                              },
                              child: KTextUtils(
                                text: "Forget Password",
                                size: 16,
                                color: black,
                                fontWeight: FontWeight.w400,
                                textDecoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: Get.height * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<AuthController>(builder: (_) {
                    return AuthButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            String email = emailController.text.trim();
                            String password = passwordController.text;
                            controller.loginUsingFirebase(
                                email: email, password: password);
                          }
                        },
                        text: controller.isLoading == false
                            ? Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            : SizedBox(
                                width: Get.width * .07,
                                height: Get.width * .07,
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                )),
                        width: MediaQuery.of(context).size.width / 1.3);
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // نص sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KTextUtils(
                    text: "Don’t have an account?",
                    size: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.none,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.signUpScreen);
                      },
                      child: KTextUtils(
                        text: "SignUp",
                        size: 18,
                        color: black,
                        fontWeight: FontWeight.w400,
                        textDecoration: TextDecoration.underline,
                      ))
                ],
              ),
              // HeightSizeBox(Get.width * .1 * .3),
              // const OrContinueWith(),
              // SizedBox(
              //   height: Get.height * .04,
              // ),
              // GetBuilder<AuthController>(
              //   builder: (_) {
              //     return GoogleAuthImage(
              //       onPressed: () {
              //         controller.googleSignupApp();
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
