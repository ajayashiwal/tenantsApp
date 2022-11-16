import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/lawyer_profile_controller.dart';

class LawyerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerProfileController.new);
  }
}
