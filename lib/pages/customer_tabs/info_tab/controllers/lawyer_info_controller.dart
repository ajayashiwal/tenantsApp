import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/network_api/network_util.dart';
import '../../../../models/lawyer_info_list_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class LawyerInfoPageController extends GetxController implements ApiInterface{

  bool isLoading = false;
  LawyerInfoListModel lawyerInfoListModel=LawyerInfoListModel();
  final NetworkUtil networkUtil = NetworkUtil();
  TextEditingController searchController=TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var message;

  @override
  void onInit() {
      lawyerInfoListApi("");

    super.onInit();
  }

  // lawyer info Listing  API
  void lawyerInfoListApi(String search) async {
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      final projectId = value.getString(AppStrings.projectId);
      networkUtil.postHeaderAuth("${Constants.projectInformation}?project_id=$projectId&search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  // lawyer Info Listing  API without Loading
  void lawyerInfoListApiWithOutLoading(String search) async {
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      final projectId = value.getString(AppStrings.projectId);
      networkUtil.postHeaderAuth("${Constants.projectInformation}?project_id=$projectId&search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  searchTextAPi(String text){
    isLoading = true;
    update();
    lawyerInfoListApi(text);
  }



  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    lawyerInfoListModel=LawyerInfoListModel();
    if (data['status'] == 1) {
    isLoading = false;
    update();
    lawyerInfoListModel = LawyerInfoListModel.fromJson(data);
    }else if(data['status'] == 0) {
      isLoading = false;
      update();
      message = data['message'];
      // ToastManager.errorToast('$message');
    }
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
