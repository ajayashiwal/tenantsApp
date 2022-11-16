import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/Update_officedetail_controller.dart';

class UpdateOfficeProfileDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UpdateOfficeDetailController.new);
  }
}
