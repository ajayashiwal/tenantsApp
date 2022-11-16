import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/contact_controller.dart';

class ContactListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ContactListPageController.new);
  }
}
