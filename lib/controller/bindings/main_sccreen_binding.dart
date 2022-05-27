 import 'package:get/get.dart';
import 'package:odc_game/controller/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put( MainController(),permanent:  true);

  }
}
