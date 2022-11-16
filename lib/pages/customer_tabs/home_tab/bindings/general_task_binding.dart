import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/general_task_controller.dart';

class GeneralTaskPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GeneralTaskPageController.new);
  }
}
