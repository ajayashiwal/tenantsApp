import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../models/lawyer_tenants_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';

class LawyerTenantsPageController extends GetxController implements ApiInterface {
  bool isLoading = false;
  LawyerTenantsModel lawyerTenantsModel=LawyerTenantsModel();
  TextEditingController searchController=TextEditingController();
  ScrollController scrollController=ScrollController();


  // api type and variables
  String? apiType;
  static const lawyerTenantList = "lawyerTenantList";
  final NetworkUtil networkUtil = NetworkUtil();
  @override
  void onInit() {
      userDetailApi("");
    super.onInit();
  }

  // Tenants Listing  API
  void userDetailApi(String search) async {
    isLoading = true;
    update();
    apiType = lawyerTenantList;
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      final projectId = value.getString(AppStrings.projectId);
      networkUtil.getAuth("${Constants.tenantListForLawyer}?project_id=$projectId&search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }
  // Tenants Listing  API without Loading
  void userDetailApiWithOutLoading(String search) async {
    apiType = lawyerTenantList;
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      final projectId = value.getString(AppStrings.projectId);
      networkUtil.getAuth("${Constants.tenantListForLawyer}?project_id=$projectId&search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  searchTextAPi(String text){
    isLoading = true;
    update();
    userDetailApi(text);
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    lawyerTenantsModel=LawyerTenantsModel();
    isLoading = false;
    update();
    lawyerTenantsModel = LawyerTenantsModel.fromJson(data);
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
