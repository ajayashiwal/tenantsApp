import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/controllers/tenants_controller.dart';

class TenantsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(TenantsPageController.new);
  }
}
