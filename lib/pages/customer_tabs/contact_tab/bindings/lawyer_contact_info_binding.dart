import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/laywer_contact_info_controller.dart';

class LawyerContactInfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerContactInfoPageController.new);
  }
}
