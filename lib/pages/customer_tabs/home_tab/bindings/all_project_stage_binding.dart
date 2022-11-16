import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/all_project_stages_controller.dart';

class AllProjectStageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AllProjectStageController.new);
  }
}
