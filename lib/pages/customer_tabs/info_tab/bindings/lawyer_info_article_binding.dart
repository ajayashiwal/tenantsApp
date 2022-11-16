import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/lawyer_info_article_controller.dart';

class LawyerInfoArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LawyerInfoArticleController.new);
  }
}
