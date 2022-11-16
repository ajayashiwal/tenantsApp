

import 'package:get/get.dart';

import '../../../models/app_content_model.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';
import '../../../network_api/toast.dart';


class JobsPageController extends GetxController implements ApiInterface{
  bool isLoading = false;
  final NetworkUtil networkUtil = NetworkUtil();
  AppContentModel appContentModel=AppContentModel();

  @override
  void onInit() {
    appContentApi();
    super.onInit();

  }
  // app content Api
  void appContentApi() async {
    isLoading = true;
    update();
    networkUtil.get(Constants.appContent, this);
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    isLoading = false;
    update();
    appContentModel=AppContentModel.fromJson(data);
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
