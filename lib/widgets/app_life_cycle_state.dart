import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/network_api/const.dart';
import 'package:tenants_shield_project/network_api/network_util.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';

import '../network_api/api_interface.dart';

class LifeCycleController extends SuperController implements ApiInterface{
  final NetworkUtil networkUtil = NetworkUtil();

  @override
  void onDetached() {
    if (kDebugMode) {
      print("onDetached");
    }
  }

  @override
  void onInactive() {
    if (kDebugMode) {
      print("onInactive");
    }
  }

  @override
  void onPaused() {
    if (kDebugMode) {
      print("onPaused");
    }
  }

  @override
  void onResumed() {
    if (kDebugMode) {
      print("onResumed");
    }
    updateOneSignalToken();
  }

  // update oneSignalToken
  void updateOneSignalToken() async {
    SharedPreferences.getInstance().then((value) {
      final userID = value.getString(AppStrings.UserID);
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.updateOneSignalToken,  authToken.toString(),this, body: {
        "oneSignalId":userID
      });
    });

  }
  @override
  void onFailure(message) {
  }

  @override
  void onSuccess(data, code) {
    update();
  }

  @override
  void onTokenExpire(message) {
  }
}
