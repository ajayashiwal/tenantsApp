import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/contact_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/lawyer_contact_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/home_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_home_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/lawyer_info_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/lawyer_profile_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/profile_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/controllers/lawyer_tenants_controller.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/controllers/tenants_controller.dart';

class DashBoardPageBinding extends Bindings {
  @override
  void dependencies() {
    //tenants login
    Get.lazyPut(DashBoardPageController.new);
    Get.lazyPut(InfoPageController.new);
    Get.lazyPut(ContactListPageController.new);
    Get.lazyPut(HomePageController.new);
    Get.lazyPut(TenantsPageController.new);
    Get.lazyPut(ProfilePageController.new);

    // lawyer login
    Get.lazyPut(LawyerInfoPageController.new);
    Get.lazyPut(LawyerProfileController.new);
    Get.lazyPut(LawyerHomePageController.new);
    Get.lazyPut(LawyerContactListPageController.new);
    Get.lazyPut(LawyerTenantsPageController.new);

  }
}
