 import 'package:get/get.dart';
import 'package:odc_game/controller/controller/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthController(),permanent: false);
  }

 }
