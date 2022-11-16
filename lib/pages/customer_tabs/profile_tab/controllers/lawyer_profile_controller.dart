import 'dart:convert';
import 'package:get/get.dart';
import '../../../../models/login_model.dart';
import '../../../../utils/shared_prefs.dart';

class LawyerProfileController extends GetxController {
  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var profileData;
  String imagesUrl = '';
  String title = '';
  String subTitle = '';
  String applicationVersion = '';

  LoginModel loginModel=LoginModel();


  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
  getProfile() {
    SharedPrefs.getProfileData().then((value) {
      profileData = json.decode(value);
      loginModel = LoginModel.fromJson(profileData);
      imagesUrl= loginModel.data!.profileImage.toString();
      title= loginModel.data!.firstName.toString();
      subTitle= loginModel.data!.lastName.toString();
      applicationVersion=loginModel.data!.applicationVersion.toString();
      update();
    });
  }
}
