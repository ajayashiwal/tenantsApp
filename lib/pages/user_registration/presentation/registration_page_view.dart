import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../appstyle/app_dimensions.dart';
import '../../../appstyle/assets_images.dart';
import '../../../navigation/app_route_maps.dart';
import '../../../tenants_localizations.dart';
import '../../../widgets/action_button_continue.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/cupertino_viewer.dart';
import '../controllers/registration_page_controller.dart';

// ignore: must_be_immutable
class RegistrationPageView extends StatelessWidget {
  bool checkBox = false;
  late  bool connected=false;
  RegistrationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationPageController>(builder: (controller) {
      return  GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.register),context),
            body: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  connected = connectivity != ConnectivityResult.none;
                  return connectionMessage(child,connected,context);
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Form(
                        key: controller.formKey,
                        child: Padding(
                          padding: AppDimensions.padding20,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(AssetsBase.layerLoginIcon,height: AppDimensions.hundred,width: AppDimensions.hundred),
                                  SizedBox(width: AppDimensions.ten),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.registerAsATenant),style: AppThemeStyles.black18),
                                        SizedBox(height: AppDimensions.twenty),
                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.DoNotHaveAnAccount),style: AppThemeStyles.blackBold18),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppDimensions.twenty),
                              Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                           connected==false?Container():
                                          Get.dialog(
                                            AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                backgroundColor: AppColors.lightWhiteColor,
                                                shape: const OutlineInputBorder(
                                                    borderSide:  BorderSide(color: AppColors.whiteColor)
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors.whiteColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                            color: AppColors.blackColor.withOpacity(0.1),
                                                            blurRadius: 5.0,
                                                          ),]
                                                      ),
                                                      width: double.infinity,
                                                      padding: AppDimensions.margin10_10_20_20,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(TenantsLocalizations.of(context)!.find(AppStrings.selectImageSource),style: AppThemeStyles.black16),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: AppDimensions.ten),
                                                    // ignore: deprecated_member_use
                                                    FlatButton.icon(
                                                      icon: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.cameraIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo),
                                                      onPressed:(){
                                                        controller.getImage(ImageSource.camera);
                                                      },
                                                      label:  Text(TenantsLocalizations.of(context)!.find(AppStrings.fromCamera),style: AppThemeStyles.blue14),
                                                    ),
                                                    // ignore: deprecated_member_use
                                                    FlatButton.icon(
                                                      icon: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.galleryIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo),
                                                      onPressed: (){
                                                        controller.getImage(ImageSource.gallery);
                                                        },
                                                      label:  Text(TenantsLocalizations.of(context)!.find(AppStrings.fromImageGallery),style: AppThemeStyles.blue14),
                                                    ),
                                                    SizedBox(height: AppDimensions.ten),
                                                  ],
                                                )),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 42,
                                              backgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                                              child: CircleAvatar(
                                                  radius: AppDimensions.forty,
                                                  backgroundColor: Colors.transparent,
                                                  backgroundImage: controller.imageFile == null
                                                      ? const AssetImage(AssetsBase.carbonUserAvatarIcon)
                                                      : FileImage(File(controller.imageFile!.path))
                                                  as ImageProvider),
                                            ),
                                            SizedBox(height: AppDimensions.five),
                                            Center(child: Text(TenantsLocalizations.of(context)!.find(AppStrings.uploadProfileImage),style: AppThemeStyles.blue14)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),

                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.projectCodeController,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabledBorder:   UnderlineInputBorder(
                                      borderSide:controller.projectCodeSelect!=true? const BorderSide(color: AppColors.grey6Color):const BorderSide(color: AppColors.redColor),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:AppColors.grey6Color),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: controller.projectCodeSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                    ),

                                    label: RichText(
                                        text:  TextSpan(
                                            text: " * ",
                                            style: const TextStyle(color: AppColors.redColor),
                                            children:  [
                                              TextSpan(
                                                  text: TenantsLocalizations.of(context)!.find(AppStrings.projectCode),
                                                  style: AppThemeStyles.blue14
                                              )
                                            ]
                                        )),
                                    suffixIconConstraints:  BoxConstraints(
                                        minHeight: AppDimensions.thirty,
                                        minWidth: AppDimensions.thirty
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: (){
                                          projectCodePopUPDialogs(
                                              TenantsLocalizations.of(context)!.find(AppStrings.whatIsAProjectCode),
                                              TenantsLocalizations.of(context)!.find(AppStrings.projectCodeDes),
                                              TenantsLocalizations.of(context)!.find(AppStrings.contactNo)
                                          );
                                        },
                                        child: Image.asset(AssetsBase.quetionMarkIcon,color: AppColors.blueColor,height: AppDimensions.twenty,width: AppDimensions.twenty)),

                                ),

                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.firstNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  enabledBorder:   UnderlineInputBorder(
                                    borderSide:controller.firstNameSelect!=true? const BorderSide(color: AppColors.grey6Color):const BorderSide(color: AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.firstNameSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.firstName),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),
                                ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.lastNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.lastNameSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.lastName),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.emailSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.email),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.phoneController,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.phoneSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(
                                              color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.phone),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),

                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.streetNameController,
                                textInputAction: TextInputAction.next,

                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.streetSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(
                                              color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.streetName),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.buildingNumberController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.buildingNoSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(
                                              color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.buildingNumber),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),
                                // decoration: InputDecoration(
                                //     enabledBorder:  const UnderlineInputBorder(
                                //       borderSide: BorderSide(color: AppColors.grey6Color),
                                //     ),
                                //     focusedBorder: const UnderlineInputBorder(
                                //       borderSide: BorderSide(color:AppColors.grey6Color),
                                //     ),
                                //     label: Text(TenantsLocalizations.of(context)!.find(AppStrings.buildingNumber)),
                                //     labelStyle: AppThemeStyles.blue14
                                // ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              TextFormField(
                                controller: controller.apartmentNumberController,
                                decoration: InputDecoration(
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: controller.apartmentNoSelect!=true?AppColors.grey6Color:AppColors.redColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color:AppColors.grey6Color),
                                  ),
                                  label: RichText(
                                      text:  TextSpan(
                                          text: " * ",
                                          style: const TextStyle(
                                              color: AppColors.redColor),
                                          children:  [
                                            TextSpan(
                                                text: TenantsLocalizations.of(context)!.find(AppStrings.apartmentNumber),
                                                style: AppThemeStyles.blue14
                                            )
                                          ]
                                      )),

                                ),
                                // decoration: InputDecoration(
                                //     enabledBorder:  const UnderlineInputBorder(
                                //       borderSide: BorderSide(color:AppColors.grey6Color),
                                //     ),
                                //     focusedBorder: const UnderlineInputBorder(
                                //       borderSide: BorderSide(color:AppColors.grey6Color),
                                //     ),
                                //     label: Text(TenantsLocalizations.of(context)!.find(AppStrings.apartmentNumber)),
                                //     labelStyle: AppThemeStyles.blue14
                                // ),
                              ),
                              SizedBox(height: AppDimensions.ten),
                              Row(
                                children: [
                                  SizedBox(
                                    height: AppDimensions.thirty,
                                    width: AppDimensions.thirty,
                                    child: Checkbox(
                                      value: checkBox,
                                      onChanged: (value) {
                                        checkBox = value!;
                                        controller.update();
                                        },
                                    ),
                                  ),
                                  SizedBox(width: AppDimensions.ten),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        connected==false?Container():AppRouteMaps.goToPrivacyPolicyPage();
                                      },
                                      child: RichText(
                                          text:  TextSpan(
                                              text: TenantsLocalizations.of(context)!.find(AppStrings.iAmAgreeToThe),
                                              style: AppThemeStyles.black14,
                                              children:  [
                                                TextSpan(
                                                    text: TenantsLocalizations.of(context)!.find(AppStrings.termsOfUseAndPrivacyPolicy),
                                                    style: AppThemeStyles.blueUnderline14
                                                ),
                                                TextSpan(
                                                    text: TenantsLocalizations.of(context)!.find(AppStrings.ofTheApplication),
                                                    style: AppThemeStyles.black14
                                                )
                                              ]
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppDimensions.twenty),
                              ActionButtonWidget(
                                  onTap: (){
                                    connected==false?Container(): submit(controller);
                                  },
                                  text:  TenantsLocalizations.of(context)!.find(AppStrings.register)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller.isLoading ? const Center(child: SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(color: AppColors.skyLightColor))):Container(),
                  ],
                )

              );
            },
          )

        ),
      );

    });
  }
// user register button
  void submit(controller) {
    if (controller.formKey.currentState!.validate()) {
      controller.update();
      if(controller.projectCodeController.text.length<4){
        controller.projectCodeSelect=true;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.projectCodeValidation));
      }else if (controller.firstNameController.text.isEmpty){
        controller.firstNameSelect=true;
        controller.projectCodeSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.firstName));
      } else if (controller.lastNameController.text.isEmpty) {
        controller.lastNameSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.lastName));
      }
      else if (controller.emailController.text.isEmpty) {
        controller.emailSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.phoneSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.email));
      }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(controller.emailController.text)){
        controller.emailSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.phoneSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.validEmail));
      }
      else if (controller.phoneController.text.isEmpty) {
        controller.phoneSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.phone));
      }else if(controller.phoneController.text.length<9){
        controller.phoneSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.streetSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.phoneValidation));
      }
      else if (controller.streetNameController.text.isEmpty) {
        controller.streetSelect=true;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.streetName));
      }
      else if (controller.buildingNumberController.text.isEmpty) {
        controller.streetSelect=false;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.buildingNoSelect=true;
        controller.apartmentNoSelect=false;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.buildingNumber));
      }
      else if (controller.apartmentNumberController.text.isEmpty) {
        controller.streetSelect=false;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=true;
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.apartmentNumber));
      }else if(checkBox==false){
        controller.streetSelect=false;
        controller.projectCodeSelect=false;
        controller.firstNameSelect=false;
        controller.lastNameSelect=false;
        controller.emailSelect=false;
        controller.phoneSelect=false;
        controller.buildingNoSelect=false;
        controller.apartmentNoSelect=false;
        showCheckBoxErrorDialogs();
      } else {
        controller.sendOtpRegistration(controller.emailController.text);
      }
    }
  }
  // show  messages for project code popup
  void projectCodePopUPDialogs(String title,String message,String contactNo) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppColors.lightWhiteColor.withOpacity(0.6),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.ten),
              borderSide:  BorderSide(color: AppColors.lightWhiteColor.withOpacity(0.1))

          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppDimensions.twenty),
              Text(
                title,
                style: AppThemeStyles.blackBold16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.twenty),
              Padding(
                padding: AppDimensions.margin0_10_10_0,
                child:
                InkWell(
                  onTap: (){
                    _makePhoneCall("tel:$contactNo");
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                      text:  TextSpan(
                          text: message,
                          style: AppThemeStyles.black16,
                          children:  [
                            TextSpan(
                                text: contactNo,
                                style: AppThemeStyles.blue16
                            )
                          ]
                      )),
                ),
              ),

              SizedBox(height: AppDimensions.ten),
              const Divider(color: AppColors.lightGreyColor,height: 1),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: AppDimensions.padding20,
                  child: Center(
                      child: Text(
                          TenantsLocalizations.of(Get.context!)!.find(AppStrings.close),
                          style: AppThemeStyles.blue16)),
                ),
              ),
            ],
          )),
    );
  }
  // ignore: non_constant_identifier_names
  Future<void> _makePhoneCall(String Url)async{
    // ignore: deprecated_member_use
    if(await canLaunch(Url)){
      // ignore: deprecated_member_use
      await launch(Url);
    }
    else{
      throw "Could not launch $Url";
    }
  }
}
