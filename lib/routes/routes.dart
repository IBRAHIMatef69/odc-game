import 'package:get/get.dart';
import 'package:odc_game/controller/bindings/auth_binding.dart';
import 'package:odc_game/controller/bindings/main_sccreen_binding.dart';
import 'package:odc_game/view/screens/auth_screen/forgot_password.dart';
import 'package:odc_game/view/screens/auth_screen/login_screen.dart';
import 'package:odc_game/view/screens/auth_screen/sign_up_screen.dart';
import 'package:odc_game/view/screens/main_screen.dart';

class Routes {
  static const mainScreen = "/mainScreen";
  static const signUpScreen = "/signUpScreen";
  static const loginScreen = "/loginScreen";
  static const forgotPassword = "/forgotPassword";

  static final routes = [
    GetPage(
      name: mainScreen,
      page: () => MainScreen(),
      bindings:[MainBinding(),AuthBinding()]
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => ForgotPassword(),
      binding: AuthBinding(),
    ),


  ];
}
