import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../navigation/app_route_maps.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';
import '../../../network_api/toast.dart';


class LoginPageController extends GetxController implements ApiInterface {
  String email="";
  TextEditingController emailController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  var argumentData = Get.arguments;
  bool isLoading = false;
  bool connected=false;

// api type and variables
  String? apiType;
  static const sendOtp = "sendOtp";
  final NetworkUtil networkUtil = NetworkUtil();

  @override
  void onInit() {
    initOneSignal();
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

  // send otp for login
  void sendOtpRegistration(String email) async {
    apiType = sendOtp;
    isLoading = true;
    update();
    networkUtil.post(Constants.sendOtp, this, body: {
      AppStrings.email: email,
      AppStrings.type: AppStrings.login,
    });
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
 void onSuccess(data, code)  {
          isLoading = false;
          update();
          ToastManager.successToast('הקוד נשלח לדוא"ל שלך בהצלחה');
          AppRouteMaps.goToOtpPage1(emailController.text,AppStrings.login,argumentData[0][AppStrings.type]);

  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
