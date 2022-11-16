import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_general_task_controller.dart';

class LawyerGeneralTaskPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerGeneralTaskPageController.new);
  }
}
