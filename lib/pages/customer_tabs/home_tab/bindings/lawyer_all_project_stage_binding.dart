import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_all_project_stages_controller.dart';

class LawyerAllProjectStageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerAllProjectStageController.new);
  }
}
