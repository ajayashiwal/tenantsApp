import 'package:get/get.dart';
import '../controllers/jobs_page_controller.dart';

class JobsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(JobsPageController.new);
  }
}
