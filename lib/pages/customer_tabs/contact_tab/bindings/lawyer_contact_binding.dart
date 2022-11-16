import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/lawyer_contact_controller.dart';

class LawyerContactListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerContactListPageController.new);
  }
}
