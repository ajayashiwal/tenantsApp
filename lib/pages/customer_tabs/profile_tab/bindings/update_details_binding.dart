import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/update_details_controller.dart';

class UpdateProfileDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UpdateProfileDetailsController.new);
  }
}
