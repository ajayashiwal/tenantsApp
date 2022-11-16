import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/widgets/app_life_cycle_state.dart';

import '../../../../models/info_list_model.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class InfoPageController extends GetxController implements ApiInterface{

  bool isLoading = false;
  InfoListModel infoListModel=InfoListModel();
  final NetworkUtil networkUtil = NetworkUtil();
  TextEditingController searchController=TextEditingController();

  @override
  void onInit() {
    Get.put(LifeCycleController());

    if(infoListModel.data==null){
      infoListApi("");
    }

    super.onInit();
  }

  // info Listing  API
  void infoListApi(String search) async {
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.projectInformationForTenant}?search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  // Info Listing  API without Loading
  void infoListApiWithOutLoading(String search) async {
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.projectInformationForTenant}?search=$search", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  searchTextAPi(String text){
    isLoading = true;
    update();
    infoListApi(text);
  }



  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    infoListModel=InfoListModel();
    isLoading = false;
    update();
    infoListModel = InfoListModel.fromJson(data);
    SharedPreferences.getInstance().then((value) {
      final infoFileId = value.getString("infoFileId");
      final infoMessageId = value.getString("infoMessageId");
      if(infoFileId!=''){
        for(int i=0; i<infoListModel.data!.length; i++){
          if(infoListModel.data![i].id.toString()==infoFileId){
          AppRouteMaps.goToInfoArticle(
                infoListModel,
                infoListModel.data![i].id.toString()
            );
           value.setString("infoFileId","");
            break;

          }
        }
      }else if(infoMessageId!=''){
        for(int i=0; i<infoListModel.data!.length; i++){
          if(infoListModel.data![i].id.toString()==infoMessageId){
            AppRouteMaps.goToInfoArticle(
                infoListModel,
                infoListModel.data![i].id.toString()
            );
            value.setString("infoMessageId","");
            break;

          }


        }
      }
      });

  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
