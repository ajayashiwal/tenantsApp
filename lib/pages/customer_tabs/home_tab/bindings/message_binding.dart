import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/message_controller.dart';

class MessagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MessagePageController.new);
  }
}
