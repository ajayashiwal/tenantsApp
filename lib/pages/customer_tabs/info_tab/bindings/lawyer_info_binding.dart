import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/lawyer_info_controller.dart';

class LawyerInfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerInfoPageController.new);
  }
}
