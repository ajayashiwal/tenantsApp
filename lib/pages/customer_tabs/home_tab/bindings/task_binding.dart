import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/task_controller.dart';

class CloseTaskPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CloseTaskPageController.new);
  }
}
