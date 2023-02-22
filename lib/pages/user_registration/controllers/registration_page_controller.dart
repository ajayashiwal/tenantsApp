import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../models/register_model.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';
import '../../../network_api/toast.dart';



class RegistrationPageController extends GetxController implements ApiInterface{
  final ImagePicker picker = ImagePicker();
  final NetworkUtil networkUtil = NetworkUtil();
  bool connected=false;
  File? imageFile;
  String imagesUrl = '';
  bool projectCodeSelect=false;
  bool firstNameSelect=false;
  bool lastNameSelect=false;
  bool emailSelect=false;
  bool phoneSelect=false;
  bool streetSelect=false;
  bool buildingNoSelect=false;
  bool apartmentNoSelect=false;
  ScrollController scrollController = ScrollController();
  TextEditingController projectCodeController=TextEditingController();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController streetNameController=TextEditingController();
  TextEditingController buildingNumberController=TextEditingController();
  TextEditingController apartmentNumberController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegisterModel registerModel=RegisterModel();
  bool isLoading = false;
  var argumentData = Get.arguments;
  String messageData="";
  String number="";



  // api type and variables
  String? apiType;
  static const sendOtp = "sendOtp";
  @override
  void onInit() {
    messageData=argumentData[0]["messageData"].split(":")[0];
    number=argumentData[0]["messageData"].split(":").last;
    super.onInit();

  }



  /// Get Image/Photo from gallery and crop
  void getImage(ImageSource source) async {
    try {
      var pickedFile = await picker.pickImage(source: source).whenComplete((){
            Get.back();
          });

      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
          // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          // compressQuality: 20,
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

  // send otp for registration
  void sendOtpRegistration(emailController) async {
    apiType = sendOtp;
    isLoading = true;
    update();
    networkUtil.post(Constants.sendOtp, this, body: {
      AppStrings.email: emailController,
      AppStrings.type: AppStrings.register
    });
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code)  {
    if (kDebugMode) {
      print("imageFile!.path....${imageFile!.path}");
    }
          isLoading = false;
          update();
          ToastManager.successToast(AppStrings.otpMessage);
          AppRouteMaps.goToOtpPage(
          projectCodeController.text,
         firstNameController.text,
        lastNameController.text,
        emailController.text,
        phoneController.text,
        streetNameController.text,
        buildingNumberController.text,
          apartmentNumberController.text,
              // ignore: unrelated_type_equality_checks
          imageFile!=null?imageFile!.path:""
          );
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
