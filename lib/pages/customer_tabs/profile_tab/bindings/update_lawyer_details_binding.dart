import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/update_lawyer_details_controller.dart';

class UpdateLawyerProfileDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UpdateLawyerDetailController.new);
  }
}
