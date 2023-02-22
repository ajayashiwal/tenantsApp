import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/navigation/app_pages.dart';
import 'package:tenants_shield_project/network_api/const.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tenants_shield_project/pages/splash_page/splash_binding.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'tenants_localizations.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Firebase.initializeApp();
    FlutterError.onError=FirebaseCrashlytics.instance.recordFlutterError;
  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true,
  );
  FlutterDownloader.registerCallback(downloadCallback);
   // initOneSignal();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    runApp(const MyApp());
}
void downloadCallback(String id, DownloadTaskStatus status, int progress){
final SendPort? send =IsolateNameServer.lookupPortByName("downloader_send_port");
send!.send([id,status,progress]);
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
    fallbackToSettings: true,

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
    }

    prefs.setString("NotificationId", p['notification_id'].toString());
    if (kDebugMode) {
      print("al;sfd'..${prefs.getString("NotificationId")}");
    }

    // NotificationClick.onClick(p['id'].toString(), p['type']);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final  _localeHe=const Locale("he");
  @override
  Widget build(BuildContext context) {
    Theme.of(context).scaffoldBackgroundColor == Colors.white
        ? _lightStatusAndNavigationBar():
         _darkStatusAndNavigationBar();
    return  GetMaterialApp(
      locale:_localeHe,
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('he', 'IL'),
      ],
      localizationsDelegates:  const [
        TenantsLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
void _darkStatusAndNavigationBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.blueColor,
      systemNavigationBarDividerColor: AppColors.blueColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

void _lightStatusAndNavigationBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.blueColor,
      systemNavigationBarDividerColor: AppColors.blueColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
