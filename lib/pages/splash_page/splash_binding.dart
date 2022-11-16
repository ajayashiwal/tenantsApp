import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/splash_page/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashController.new);
  }
}
