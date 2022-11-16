import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../navigation/app_route_maps.dart';
import '../../network_api/const.dart';
import '../../utils/app_strings.dart';


class SplashController extends GetxController {
  @override
  void onInit() async {
    // initialize();
    // _checkVersion();

    initOneSignal();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      Future<dynamic>.delayed(
          const Duration(
            seconds: 2,
          ),
          authToken!=null ? authToken==""?AppRouteMaps.goToFirstPage: AppRouteMaps.goToDashBoardPage : AppRouteMaps.goToFirstPage
      );
    });
    super.onInit();
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
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: false,

    );
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      if (kDebugMode) {
        print('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
        print("addinal data ${result.notification.additionalData}");
      }

      var data = json.encode(result.notification.additionalData);
      if (kDebugMode) {
        print("al;sfd'..$data");
      }


      Map p = jsonDecode(data);
      if (kDebugMode) {
        print("al;sfd'..${p['notification_id'].toString()}");
        print("type;sfd'..${p['type'].toString()}");
      }

      prefs.setString("NotificationId", p['notification_id'].toString());
      // prefs.setString("NotificationType", p['type'].toString());
      if (kDebugMode) {
        print("al;sfd'..${prefs.getString("NotificationId")}");
      }

      // NotificationClick.onClick(p['id'].toString(), p['type']);
    });
  }

   checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.app.tenantshield",
    );
    final status = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
      context: Get.context!,
      versionStatus: status!,
      dialogTitle: "UPDATE!!!",
      dismissButtonText: "Skip",
      dialogText: "Please update the app from ${status.localVersion} to ${status.storeVersion}",
      dismissAction: () {
        SystemNavigator.pop();
      },
      updateButtonText: "Lets update",
    );
    //
    if (kDebugMode) {
      print("DEVICE : ${status.localVersion}");
      print("STORE : ${status.storeVersion}");

    }
  }

}
