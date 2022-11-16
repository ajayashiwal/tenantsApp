import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/message_list_model.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/notifcation_calback.dart';
import '../../../../widgets/notificaiton_method.dart';

class MessagePageController extends GetxController implements ApiInterface, NotificationClick{
  bool isLoading = false;
  MessageListModel messageListModel=MessageListModel();
  ScrollController scrollController=ScrollController();
  final NetworkUtil networkUtil = NetworkUtil();
  var argumentData = Get.arguments;

  // api type and variables
  String? apiType;
  static const messageList = "messageList";
  static const messageDelete = "messageDelete";
  static const readMessage = "readMessage";



  @override
  void onInit() async{
    NotificationMedthod.initPlatformState(this);
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString("NotificationId", "");
    if(messageListModel.data==null){
      messageListApi();
    }

    super.onInit();
  }

  // Message Listing  API
  void messageListApi() async {
    apiType = messageList;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth(Constants.messages, authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }
  // Message Listing  API
  void messageListApiWithoutLoading() async {
    apiType = messageList;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth(Constants.messages, authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }
  // read Message  API
  void readMessageApi(String messageId) async {
    apiType = readMessage;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(
        "${Constants.readMessage}?message_id=$messageId", authToken.toString(), this,
      );
    });

  }

  // message Delete  API
  void messageDeleteApi(String messageId) async {
    apiType = messageDelete;
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
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  Future<void> onSuccess(data, code) async {

    switch (apiType) {
      case messageList:
        isLoading = false;
        update();
        messageListModel = MessageListModel.fromJson(data);
        SharedPreferences.getInstance().then((value) async {
          final notificationId = value.getString("NotificationId");
          if (kDebugMode) {
            print("NotificationId...$notificationId");
            print("notification_id...${argumentData[0]["notification_id"]}");
          }
          if(notificationId!=''){
            readMessageApi(notificationId!);
            for(int i=0; i<messageListModel.data!.length; i++){
              if(messageListModel.data![i].id.toString()==notificationId){
                var result = await AppRouteMaps.goToDeleteMessagePage(
                    messageListModel,
                    messageListModel.data![i].id.toString()
                );
                if(result!=null )
                {
                  if(result=="Yes"){
                    messageListApi();
                    update();
                  }
                }
                break;

              }


            }
          }
        });

        break;
      case messageDelete:
        isLoading = false;
        update();
        messageListApi();
        break;
      case readMessage:
        isLoading = false;
        update();


    }
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onClick(id, String type, var messageId) {
  }

  @override
  void updateBadge(id, String type,var messageId) {
    messageListApi();
    update();
  }

}
