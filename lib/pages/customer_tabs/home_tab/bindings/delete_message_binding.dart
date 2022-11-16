import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/delete_message_controller.dart';

class DeleteMessagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DeletePageController.new);
  }
}
