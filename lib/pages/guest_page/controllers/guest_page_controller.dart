import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/app_content_model.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';

class GuestPageController extends GetxController implements ApiInterface{
  bool isLoading = false;
  final NetworkUtil networkUtil = NetworkUtil();
  AppContentModel appContentModel=AppContentModel();
  double androidLatestVersion=0.0;
  bool showDialogAndroid=false;
  bool showDialogIos=false;
  String messageData="";
  PackageInfo packageInfo = PackageInfo(
    appName: AppStrings.Unknown,
    packageName: AppStrings.Unknown,
    version: AppStrings.Unknown,
    buildNumber: AppStrings.Unknown,
    buildSignature: AppStrings.Unknown,
  );
  @override
  void onInit() {
    appContentApi();
    initPackageInfo();
    super.onInit();
    initOneSignal();
  }
  // app content Api
  void appContentApi() async {
    isLoading = true;
    update();
    networkUtil.get(Constants.appContent, this);
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
  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.app.tenantshield",
  //     iOSId: "app.magendayarim"
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   if(status!=null){
  //     newVersion.showUpdateDialog(
  //       context: Get.context!,
  //       versionStatus: status,
  //       dialogTitle: "UPDATE!!!",
  //       dismissButtonText: "Skip",
  //       dialogText: "Please update the app from ${status.localVersion} to ${status.storeVersion}",
  //       dismissAction: () {
  //         SystemNavigator.pop();
  //       },
  //       updateButtonText: "Lets update",
  //     );
  //     //
  //     if (kDebugMode) {
  //       print("DEVICE : ${status.localVersion}");
  //       print("STORE : ${status.storeVersion}");
  //
  //     }
  //   }
  //
  // }
  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    // ignore: deprecated_member_use
    if (await canLaunch(appStoreLink)) {
      // ignore: deprecated_member_use
      await launch(appStoreLink);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();
  }


  @override
  void onFailure(message) {
    // ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    isLoading = false;
    update();
    appContentModel=AppContentModel.fromJson(data);
    String apiVersionAndroid = appContentModel.data!.generalSetting!.androidLatestVersion;
    String apiVersionIos = appContentModel.data!.generalSetting!.iosLatestVersion;
    messageData=appContentModel.data!.generalSetting!.messageData.toString();
    if(apiVersionAndroid.length<4){
      apiVersionAndroid = "$apiVersionAndroid.0";
    }
    if(apiVersionIos.length<4){
      apiVersionIos = "$apiVersionIos.0";
    }
    List<String> apiAndroidVersionList = apiVersionAndroid.split(".");
    List<String> apiIosVersionList = apiVersionIos.split(".");
    String appVersion = packageInfo.version;
    List<String> appVersionList = appVersion.split(".");
    if(apiAndroidVersionList.length== appVersionList.length) {
      for (int i = 0; i < apiAndroidVersionList.length; i++) {
        if(int.parse(apiAndroidVersionList[i])>int.parse(appVersionList[i])){
          if (kDebugMode) {
            print("api version higher");
          }
          showDialogAndroid=true;
          break;
        }else{
          showDialogAndroid=false;
          if (kDebugMode) {
            print("all api version lower");
          }
        }
      }
    }
    if(apiIosVersionList.length== appVersionList.length) {
      for (int i = 0; i < apiIosVersionList.length; i++) {
        if(int.parse(apiIosVersionList[i])>int.parse(appVersionList[i])){
          if (kDebugMode) {
            print("api version higher");
          }
          showDialogIos=true;
          break;
        }else{
          showDialogIos=false;
          if (kDebugMode) {
            print("all api version lower");
          }
        }
      }
    }

  }

  @override
  void onTokenExpire(message) {
    // ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }


}
