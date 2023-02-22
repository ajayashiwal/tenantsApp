// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_view.dart';
import 'package:tenants_shield_project/widgets/notifcation_calback.dart';
import '../../../../models/app_content_model.dart';
import '../../../../models/message_list_model.dart';
import '../../../../models/project_stages_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_life_cycle_state.dart';
import '../../../../widgets/notificaiton_method.dart';
import '../../dashboard_bar/dashboard_bar_binding.dart';

class HomePageController extends GetxController implements ApiInterface, NotificationClick{
  late  bool connected=false;
  int activeStep = 5;
  bool goNext = false;
  bool goPrevious = false;
  int? visibleIndex;
  // ignore: non_constant_identifier_names
  int STEPS = 5;
  final pageController = PageController();

  ScrollController scrollController=ScrollController();
  final NetworkUtil networkUtil = NetworkUtil();
  bool isLoading = false;
  String unSeenMessage="";
  var count;
  var finishedCount;
  var startedCount;
  var pendingCount;
  MessageListModel messageListModel=MessageListModel();
  ProjectStagesModel projectStagesModel=ProjectStagesModel();
  PackageInfo _packageInfo = PackageInfo(
    appName: AppStrings.Unknown,
    packageName: AppStrings.Unknown,
    version: AppStrings.Unknown,
    buildNumber: AppStrings.Unknown,
    buildSignature: AppStrings.Unknown,
  );


  // api type and variables
  String? apiType;
  static const messageList = "messageList";
  static const projectStagesList = "projectStagesList";
  static const appContentApiText = "appContentApiText";

  @override
  void onInit() {
    Get.put(LifeCycleController());

    initOneSignal();
    initOneSignal();

    NotificationMedthod.initPlatformState(this);
    SharedPreferences.getInstance().then((value) {
      final notificationId = value.getString("NotificationId");
      if (kDebugMode) {
        print("NotificationId...$notificationId");
      }
    });
    if(projectStagesModel.data==null) {
      projectStagesListApi();
    }

    initPackageInfo();

    super.onInit();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    update();
  }


  Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId(Constants.oneSignalAppId);
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    if (kDebugMode) {
      print("osUserID=> $osUserID");
    }
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setString(AppStrings.projectId, "2");
    if(osUserID!=null) {
      prefs.setString(AppStrings.UserID, osUserID);

    }
    // await OneSignal.shared.promptUserForPushNotificationPermission(
    //   fallbackToSettings: true,
    // );
  }
  // project stages Listing  API
  void projectStagesListApi() async {
    apiType=projectStagesList;

    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final userID = value.getString(AppStrings.UserID);

      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.projectStagesStatusList}?${AppStrings.oneSignalId}=$userID", authToken.toString(), this);
      if (kDebugMode) {
        print("Auth Token$authToken");
        print("${Constants.projectStagesStatusList}?${AppStrings.oneSignalId}=$userID");
      }});


  }
// project stages Listing  API without loading
  void projectStagesListApiWithOutLoading() async {
    apiType=projectStagesList;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth(Constants.projectStagesStatusList, authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  @override
  void onFailure(message) {
    // ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) async{
    if (data['status'] == 1) {
      switch (apiType) {
        case messageList:
          isLoading = false;
          update();
          messageListModel = MessageListModel.fromJson(data);
          count = messageListModel.data!.where((c) => c.isRead==0).length;
          break;
        case projectStagesList:
          isLoading = false;
          update();
          projectStagesModel = ProjectStagesModel.fromJson(data);
          for(int i=0; i<projectStagesModel.data!.stages!.length; i++){
            if(projectStagesModel.data!.stages![i].status.toString()=="Started"){
              visibleIndex=projectStagesModel.data!.stages![i].stageId-1;
              update();
            }
          }
          finishedCount = projectStagesModel.data!.stages!.where((c) => c.status=="Finished").length;
          startedCount = projectStagesModel.data!.stages!.where((c) => c.status=="Started").length;
          pendingCount = projectStagesModel.data!.stages!.where((c) => c.status=="Pending").length;



      }

    }else if(data['status'] == 0) {
      isLoading = false;
      update();
    }
    SharedPreferences.getInstance().then((value)  {
      var notificationId = value.getString("NotificationId");
      var notificationType = value.getString("type");
      if (kDebugMode) {
        print("notificationId..$notificationId}");
        print("notificationType..$notificationType}");

      }
      if(notificationId !=""){
        if(notificationType=="New information file"){
          Get.offAll(() => DashBoardBarView(
            isSelected: 3,
          ),
              binding: DashBoardPageBinding(),
              transition: Transition.fadeIn );
        }
        else{
          AppRouteMaps.goToMessagePage(notificationId!);
        }

      }
    });
  }

  @override
  void onTokenExpire(message) {
    // ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }




  @override
  Future<void> onClick(id, String type, messageId) async {
    // AppRouteMaps.goToMessagePage(id);
    if (kDebugMode) {
      print("type......$type");
      print("id......$id");
      print("messageId......$messageId");
    }
        if(type=="New information file"){
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("infoFileId", messageId.toString());
          Get.offAll(() => DashBoardBarView(
            isSelected: 4,
          ),
              binding: DashBoardPageBinding(),
              transition: Transition.fadeIn);
          update();
        }else if(type=="Project Stage"){
          AppRouteMaps.goToAllProjectStage(projectStagesModel);
    }
        else{
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("NotificationId", id);
          final notificationValueId = prefs.getString("NotificationId");

          AppRouteMaps.goToMessagePage(id);
        }
  }

  @override
  void updateBadge(id, String type,messageId) {
  }
}
