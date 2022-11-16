import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/guest_page/controllers/guest_page_controller.dart';


class GuestPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GuestPageController.new);
  }
}
