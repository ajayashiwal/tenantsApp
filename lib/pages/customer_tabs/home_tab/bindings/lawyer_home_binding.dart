import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_home_controller.dart';

class LawyerHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerHomePageController.new);
  }
}
