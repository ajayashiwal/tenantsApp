import 'package:get/get.dart';
import '../controllers/general_info_page_controller.dart';

class GeneralInfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GeneralInfoPageController.new);
  }
}
