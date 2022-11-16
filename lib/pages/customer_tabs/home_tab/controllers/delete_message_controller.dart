import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/message_list_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class DeletePageController extends GetxController implements ApiInterface{
  bool isLoading = false;
  var argumentData = Get.arguments;
  MessageListModel? messageListModel;
  String fileName="";
  String id="";
  Data? data;
  final NetworkUtil networkUtil = NetworkUtil();




  @override
  void onInit() {
    super.onInit();
    messageListModel  =argumentData[0][AppStrings.messageListModel] as MessageListModel;
    id=argumentData[0]["id"];
    data=messageListModel!.data!.firstWhereOrNull((element)=> element.id.toString()==id);
  }


  // message Delete  API
  void messageDeleteApi(String messageId) async {
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.deleteMessage, authToken.toString(), this,body: {
        "message_id":messageId
      });
    });

  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    isLoading = false;
    update();
    Get.back(result: "Yes");

  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
