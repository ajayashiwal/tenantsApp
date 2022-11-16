import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/controllers/lawyer_tenants_controller.dart';

class LawyerTenantsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerTenantsPageController.new);
  }
}
