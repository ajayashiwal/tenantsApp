import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_article_controller.dart';

class InfoArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(InfoArticleController.new);
  }
}
