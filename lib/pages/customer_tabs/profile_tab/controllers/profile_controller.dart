import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/widgets/app_life_cycle_state.dart';
import '../../../../models/register_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/shared_prefs.dart';

class ProfilePageController extends GetxController implements ApiInterface{
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imagesUrl = '';
  String profileName = '';
  String applicationVersion = '';
  String lastName = '';
  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var profileData;

  RegisterModel registerModel=RegisterModel();

// api type and variables
  String? apiType;
  static const deleteAccount = "deleteAccount";
  static const userDetail = "userDetail";
  final NetworkUtil networkUtil = NetworkUtil();

  @override
  void onInit() {
    Get.put(LifeCycleController());

    getProfile();

    super.onInit();
  }
  getProfile() {
    SharedPrefs.getProfileData().then((value) {
      profileData = json.decode(value);
      registerModel = RegisterModel.fromJson(profileData);
      imagesUrl= registerModel.data!.profileImage.toString();
      profileName= registerModel.data!.firstName.toString();
      lastName= registerModel.data!.lastName.toString();
      applicationVersion= registerModel.data!.applicationVersion.toString();
      update();
    });
  }

  /// Get Image/Photo from gallery and crop
  void getImage(ImageSource source) async {
    try {
      var pickedFile = await picker.pickImage(source: source).whenComplete((){
        Get.back();
      });

      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      );
      debugPrint(croppedFile!.path);
      if (croppedFile.path.isNotEmpty) {
        imageFile = File(croppedFile.path);
        imageFile!.path;
        imagesUrl = '';
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // delete Account API
  void deleteAccountApi() async {
    apiType = deleteAccount;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth(Constants.deleteAccount, authToken.toString(), this );
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
    isLoading = false;
    update();
    AppRouteMaps.goToGuestPage();
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
