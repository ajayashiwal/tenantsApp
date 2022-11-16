import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/contact_list_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_life_cycle_state.dart';

class ContactListPageController extends GetxController  implements ApiInterface{
  bool isLoading = false;
  final NetworkUtil networkUtil = NetworkUtil();
  ContactListModel contactListingModel=ContactListModel();
  ScrollController scrollController=ScrollController();

  @override
  void onInit() {
    Get.put(LifeCycleController());

    if(contactListingModel.data==null){
      contactListingApi("");
    }
    super.onInit();
  }

// Contact Listing  API
  void contactListingApi(String search) async {
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.contactList}?${AppStrings.search}=$search", authToken.toString(), this );
    });

  }
  // Contact Listing  API without loading
  void contactListingApiWithLoading(String search) async {
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.contactList}?${AppStrings.search}=$search", authToken.toString(), this );
    });

  }

  contactSearchTextAPi(String text){
    isLoading = true;
    update();
    contactListingApi(text);
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    isLoading = false;
    update();
    contactListingModel = ContactListModel.fromJson(data);
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
