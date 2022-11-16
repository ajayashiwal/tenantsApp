import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/user_detail_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class UpdateOfficeDetailController extends GetxController implements ApiInterface{
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imagesUrl = '';


  // api type and variables
  String? apiType;
  static const userDetail = "userDetail";
  static const updateOfficeProfile = "updateOfficeProfile";
  final NetworkUtil networkUtil = NetworkUtil();
  TextEditingController officeNameController=TextEditingController();
  TextEditingController subtitleController=TextEditingController();
  TextEditingController officePhoneController=TextEditingController();
  TextEditingController officeEmailController=TextEditingController();
  TextEditingController officeAddressController=TextEditingController();

  @override
  void onInit() {
    userDetailApi();
    super.onInit();
  }


  // User Details  API
  void userDetailApi() async {
    apiType = userDetail;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth(Constants.userDetail, authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }


  //  updateProfile Api
  void updateOfficeProfileApi(String name,String subtitle, String phone,String email,String address) async {
    apiType = updateOfficeProfile;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.updateOfficeProfile,authToken.toString(), this, body: {
        AppStrings.office_name: name,
        AppStrings.sub_title: subtitle,
        AppStrings.office_phone: phone,
        AppStrings.office_email: email,
        AppStrings.office_address:address,
      });
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    final userDetails = UserDetailModel.fromJson(data);
     switch (apiType) {
        case userDetail:
          isLoading = false;
          update();
          officeNameController.text= userDetails.data!.officeInfo!.name;
          subtitleController.text= userDetails.data!.officeInfo!.subTitle;
          officePhoneController.text= userDetails.data!.officeInfo!.phone;
          officeEmailController.text= userDetails.data!.officeInfo!.email;
          officeAddressController.text= userDetails.data!.officeInfo!.phone;
          break;
      case updateOfficeProfile:
        isLoading = false;
        update();
        Get.back();
        break;
      }
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
