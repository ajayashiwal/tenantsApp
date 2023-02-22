import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/login_model.dart';
import '../../../models/register_model.dart';
import '../../../navigation/app_route_maps.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';
import '../../../network_api/toast.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/shared_prefs.dart';


class OtpPageController extends GetxController implements ApiInterface{
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegisterModel registerModel=RegisterModel();
  var argumentData = Get.arguments;
  bool checkBox = false;
  late  bool connected=false;
  bool isLoading = false;
  PackageInfo _packageInfo = PackageInfo(
    appName: AppStrings.Unknown,
    packageName: AppStrings.Unknown,
    version: AppStrings.Unknown,
    buildNumber: AppStrings.Unknown,
    buildSignature: AppStrings.Unknown,
  );

// api type and variables
  String? apiType;
  static const register = "register";
  static const login = "login";
  static const sendOtp = "sendOtp";
  String? isType="";
  String? emailForOtp="";
  final NetworkUtil networkUtil = NetworkUtil();

  @override
  void onInit() {
    initOneSignal();
     isType=argumentData[0][AppStrings.isType];
     emailForOtp=argumentData[0][AppStrings.email];
     if (kDebugMode) {
       print("version${Platform.version}");
       print("_packageInfo.version${_packageInfo.version}");
       print("emailForOtp$emailForOtp");
       print("imagepath.....${argumentData[0][AppStrings.imageUrl]??""}");
     }
     initPackageInfo();
     super.onInit();
  }
  // Create oneSignal key
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
  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    update();
  }

  // user register with multipart Api
  void uploadProfileImage(String otp) async {
    apiType = register;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final userID = value.getString(AppStrings.UserID);
      networkUtil.uploadMultipartImage(
          lastName: argumentData[0][AppStrings.lastName],
          projectCode: argumentData[0][AppStrings.projectCode],
          otp: otp,
          buildingName: argumentData[0][AppStrings.buildingName],
          oneSignalId: userID??"",
          device: Platform.isAndroid ? AppStrings.Android : AppStrings.IOS,
          apartmentName: argumentData[0][AppStrings.apartmentName],
          streetName: argumentData[0][AppStrings.streetName],
          firstName: argumentData[0][AppStrings.firstName],
          apiInterface: this,
          version: _packageInfo.version,
          email: argumentData[0][AppStrings.email],
          phone: argumentData[0][AppStrings.phone],
          imagePath: argumentData[0][AppStrings.imageUrl]??"",
          url: Constants.register
      );
    });

  }

// user loginApi  Api
  void loginApi(String otp) async {
    apiType = login;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final userID = value.getString(AppStrings.UserID);
      networkUtil.post(Constants.login,this, body: {
        AppStrings.email: argumentData[0][AppStrings.email],
        AppStrings.otp:otp,
        AppStrings.type:argumentData[0][AppStrings.loginType],
        AppStrings.device:Platform.isAndroid ? AppStrings.Android : AppStrings.IOS,
        AppStrings.applicationVersion:_packageInfo.version,
        AppStrings.oneSignalId:userID??""
      });
    });

  }

  // send otp for login
  void sendOtpRegistration(String email) async {
    apiType = sendOtp;
    update();
    networkUtil.post(Constants.sendOtp, this, body: {
      AppStrings.email: email,
      AppStrings.type: AppStrings.login,
    });
  }

  @override
  void onFailure(message) {
    // ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
  @override
  Future<void> onSuccess(data, code) async {
    final prefs = await SharedPreferences.getInstance();
    final loginModel = LoginModel.fromJson(data);
      final registerModel = RegisterModel.fromJson(data);
          switch (apiType) {
          case login:
          await prefs.setString(AppStrings.token, loginModel.token);
          await prefs.setString(AppStrings.type, loginModel.data!.type);
          var d = jsonEncode(data);
          SharedPrefs.saveProfileData(d);
          isLoading = false;
          update();
          AppRouteMaps.goToDashBoardPage();
          break;
          case register:
              isLoading = false;
              update();
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(AppStrings.token, registerModel.token);
              await prefs.setString(AppStrings.type, "tenant");
              var d = jsonEncode(data);
              SharedPrefs.saveProfileData(d);
              AppRouteMaps.goToDashBoardPage();
              break;
            case sendOtp:
              update();
              ToastManager.successToast('הקוד נשלח לדוא"ל שלך בהצלחה');
          }
  }

  @override
  void onTokenExpire(message) {
    // ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

}
