import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/network_api/const.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:tenants_shield_project/widgets/notifcation_calback.dart';

class NotificationMedthod{
  static initPlatformState(NotificationClick callBack) async {
    await OneSignal.shared.setAppId(Constants.oneSignalAppId);
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    final prefs = await SharedPreferences.getInstance();
    if(osUserID!=null) {
      prefs.setString(AppStrings.UserID, osUserID);

    }
    // await OneSignal.shared.promptUserForPushNotificationPermission(
    //   fallbackToSettings: true,
    // );
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      if (kDebugMode) {
        print('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
        print("addinal data ${result.notification.additionalData}");
      }

      var data = json.encode(result.notification.additionalData);
      Map p = jsonDecode(data);
      if (kDebugMode) {
        print("p['type']...${p['type']}");
      }
      prefs.setString("NotificationType", p['type']);

      // print("result type==========" +
      //     result.notification.payload.rawPayload!.toString());

      callBack.onClick(p['notification_id'].toString(), p['type'],p["message_id"]);
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) {
          if (kDebugMode) {
            print('FOREGROUND HANDLER CALLED WITH: $event');
            print("addinal data ${event.notification.additionalData}");

          }



          callBack.updateBadge("","","");
        });
  }
}