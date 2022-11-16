import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomePageController.new);
  }
}
