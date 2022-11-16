import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../models/tenant_list_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../widgets/app_life_cycle_state.dart';

class TenantsPageController extends GetxController implements ApiInterface {
  bool isLoading = false;
  TenantListModel tenantListingModel=TenantListModel();
  TextEditingController searchController=TextEditingController();
  ScrollController scrollController=ScrollController();


  // api type and variables
  String? apiType;
  static const tenantList = "tenantList";
  final NetworkUtil networkUtil = NetworkUtil();
  @override
  void onInit() {
    Get.put(LifeCycleController());

    if(tenantListingModel.data==null){
      userDetailApi("");
    }

    super.onInit();
  }

  // Tenants Listing  API
  void userDetailApi(String search) async {
    isLoading = true;
    update();
    apiType = tenantList;
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.tenantList}?search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }
  // Tenants Listing  API without Loading
  void userDetailApiWithOutLoading(String search) async {
    apiType = tenantList;
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.tenantList}?search=$search", authToken.toString(), this );
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
    tenantListingModel=TenantListModel();
          isLoading = false;
          update();
          tenantListingModel = TenantListModel.fromJson(data);
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
