import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/task_details_controller.dart';

class CloseTaskDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CloseTaskDetailsPageController.new);
  }
}
