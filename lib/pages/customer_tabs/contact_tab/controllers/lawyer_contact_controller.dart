import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/lawyer_contact_list.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class LawyerContactListPageController extends GetxController  implements ApiInterface{
  bool isLoading = false;
  final NetworkUtil networkUtil = NetworkUtil();
  LawyerContactListModel lawyerContactListModel=LawyerContactListModel();
  ScrollController scrollController=ScrollController();
  var message="";

  @override
  void onInit() {
    lawyerContactListingApi("");
    super.onInit();
  }

// lawyer Contact Listing  API
  void lawyerContactListingApi(String search) async {
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      final projectId = value.getString(AppStrings.projectId);
      if (kDebugMode) {
        print("projectIdName...$projectId");
      }
      networkUtil.postHeaderAuth("${Constants.lawyerContactList}?project_id=$projectId&${AppStrings.search}=$search", authToken.toString(), this );
    });

  }
  // Lawyer Contact Listing  API without loading
  void lawyerContactListingApiWithLoading(String search) async {
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      SharedPreferences.getInstance().then((value) {
        final projectId = value.getString(AppStrings.projectId);
        networkUtil.postHeaderAuth("${Constants.lawyerContactList}?project_id=$projectId&${AppStrings.search}=$search", authToken.toString(), this );

      });
    });

  }

  contactSearchTextAPi(String text){
    isLoading = true;
    update();
    lawyerContactListingApi(text);
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {

    if (data['status'] == 1) {
      isLoading = false;
      update();
      lawyerContactListModel = LawyerContactListModel.fromJson(data);
    }else if(data['status'] == 0) {
      isLoading = false;
      update();
      message = data['message'];
      // ToastManager.errorToast('$message');
    }

  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
