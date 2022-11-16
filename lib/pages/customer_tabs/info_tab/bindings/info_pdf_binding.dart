import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_pdf_controller.dart';

class InfoPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(InfoPdfController.new);
  }
}
