import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_controller.dart';

class InfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(InfoPageController.new);
  }
}
