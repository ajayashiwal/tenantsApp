import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../models/register_model.dart';
import '../../../../models/user_detail_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import 'package:http/http.dart' as http;
import '../../../../network_api/toast.dart';
import '../../../../utils/shared_prefs.dart';

class UpdateProfileDetailsController extends GetxController implements ApiInterface{
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  File? imageFile;
  String imagesUrl = '';
  // ignore: prefer_typing_uninitialized_variables
  var profileData;
  RegisterModel registerModel=RegisterModel();
  UserDetailModel userDetails=UserDetailModel();
  // api type and variables
  String? apiType;
  static const userDetail = "userDetail";
  static const updateProfile = "updateProfile";
  final NetworkUtil networkUtil = NetworkUtil();
  TextEditingController projectCodeController=TextEditingController();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController streetNameController=TextEditingController();
  TextEditingController buildingNumberController=TextEditingController();
  TextEditingController apartmentNumberController=TextEditingController();

  @override
  void onInit() {
    userDetailApi();
    // getProfile();
    super.onInit();
  }


// get profile data without api
  getProfile() {
    SharedPrefs.getProfileData().then((value) {
      profileData = json.decode(value);
      registerModel = RegisterModel.fromJson(profileData);
      imagesUrl= registerModel.data!.profileImage.toString();
      update();
    });
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
 // update profile image
  Future<dynamic> uploadProfileImage(
      String email,
      String firstName,
      String lastName,
      String phone,
      String streetName,
      String buildingNumber,
      String apartmentNumber,
      String imageUrl,
      context) async {
    isLoading = true;
    update();
    final token = (await SharedPreferences.getInstance()).getString(AppStrings.token);
    final request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.updateProfile));
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",

    };
    request.headers.addAll(headers);
    if(imageUrl!=""){
      final multipartFile = await http.MultipartFile.fromPath(AppStrings.profile_image, imageUrl);
      request.files.add(multipartFile);
    }
    request.fields[AppStrings.email] = email.toString();
    request.fields[AppStrings.firstName] = firstName.toString();
    request.fields[AppStrings.lastName] = lastName.toString();
    request.fields[AppStrings.phone] = phone.toString();
    request.fields[AppStrings.street_name] = streetName.toString();
    request.fields[AppStrings.building_number] = buildingNumber.toString();
    request.fields[AppStrings.apartment_number] = apartmentNumber.toString();
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      print("response$response");
    }
    if (kDebugMode) {
      print("response${request.files} + ${request.fields} ");
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      var d = jsonEncode(data);
      SharedPrefs.saveProfileData(d);
      isLoading = false;
      update();
      Get.back(result: AppStrings.Yes);
    } else if (response.statusCode == 401) {
    } else {
    }
  }




  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code)  {
     userDetails = UserDetailModel.fromJson(data);
              isLoading = false;
              update();
              firstNameController.text= userDetails.data!.firstName;
              lastNameController.text= userDetails.data!.lastName;
              emailController.text= userDetails.data!.email;
              phoneController.text= userDetails.data!.phone;
              streetNameController.text= userDetails.data!.streetName;
              buildingNumberController.text= userDetails.data!.buildingNumber;
              apartmentNumberController.text= userDetails.data!.apartmentNumber;
              imagesUrl=userDetails.data!.profileImage.toString();
          }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

}
