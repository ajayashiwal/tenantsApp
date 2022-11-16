import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/contact_info_controller.dart';

class ContactInfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ContactInfoPageController.new);
  }
}
