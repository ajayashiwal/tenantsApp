import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/update_lawyer_details_controller.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/action_button_continue.dart';
import '../../../../widgets/app_bar.dart';


// ignore: must_be_immutable
class UpdateLawyerProfileDetails extends StatelessWidget {
  late  bool connected=false;
  UpdateLawyerProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateLawyerDetailController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar1(TenantsLocalizations.of(context)!.find(AppStrings.updatePersonalDetails),context),
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
            connected = connectivity != ConnectivityResult.none;
            return connectionMessage(child,connected,context);
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/4.5,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                          color: AppColors.skyHighLightColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(AppDimensions.thirty),
                            bottomRight: Radius.circular(AppDimensions.thirty),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                controller.getImage(ImageSource.camera);
                                              },
                                              child: Padding(
                                                padding: AppDimensions.margin10_10_20_0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.cameraIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo),
                                                    SizedBox(width: AppDimensions.twenty),
                                                    Text(TenantsLocalizations.of(context)!.find(AppStrings.fromCamera),style: AppThemeStyles.blue14),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                controller.getImage(ImageSource.gallery);
                                              },
                                              child: Padding(
                                                padding: AppDimensions.margin10_10_20_0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.galleryIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo),
                                                    SizedBox(width: AppDimensions.twenty),
                                                    Text(TenantsLocalizations.of(context)!.find(AppStrings.fromImageGallery),style: AppThemeStyles.blue14),

                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),

                                        // ignore: deprecated_member_use
                                        // FlatButton.icon(
                                        //   icon: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.cameraIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo),
                                        //   onPressed:(){
                                        //     controller.getImage(ImageSource.camera);
                                        //   },
                                        //   label:  Text(TenantsLocalizations.of(context)!.find(AppStrings.fromCamera),style: AppThemeStyles.blue14),
                                        // ),
                                        // ignore: deprecated_member_use
                                        // FlatButton.icon(
                                        //   icon: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.galleryIcon),height: AppDimensions.twentyTwo,width: AppDimensions.twentyTwo,),
                                        //   onPressed: (){
                                        //     controller.getImage(ImageSource.gallery);
                                        //     },
                                        //   label:  Text(TenantsLocalizations.of(context)!.find(AppStrings.fromImageGallery),style: AppThemeStyles.blue14),
                                        // ),
                                        SizedBox(height: AppDimensions.ten),
                                      ],
                                    )),
                              );
                            },
                              child:
                              controller.imageFile == null?(controller.imagesUrl!="null" && controller.imagesUrl!=""? ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50)),
                                child: SizedBox(
                                  height: AppDimensions.hundred,
                                  width: AppDimensions.hundred,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.imagesUrl,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: AppColors.greyColor)),
                                  ),
                                ),
                              ):CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                                child: const CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:  AssetImage(AssetsBase.carbonUserAvatarIcon)),
                              )):CircleAvatar(
                                radius: AppDimensions.fifty,
                                backgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                                child:  CircleAvatar(
                                    radius: AppDimensions.fortyEight,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:  FileImage(File(controller.imageFile!.path))),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: AppDimensions.padding20,
                      child: Column(
                        children: [
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.firstNameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey6Color),
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
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey6Color),
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
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey6Color),
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
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey6Color),
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.phone),
                                            style: AppThemeStyles.blue14
                                        )
                                      ]
                                  )),

                            ),
                          ),

                          SizedBox(height: AppDimensions.ten),
                          SizedBox(height: AppDimensions.fifty),
                          ActionButtonWidget(
                            onTap: (){
                              connected == false
                                  ? Container():  controller.uploadProfileImage(
                                  controller.emailController.text,
                                  controller.firstNameController.text,
                                  controller.lastNameController.text,
                                  controller.phoneController.text,
                                  AppStrings.street_name,
                                  "",
                                  "",
                                  controller.imageFile!=null?controller.imageFile!.path:"",
                                  context
                              );
                            },
                            text:  TenantsLocalizations.of(context)!.find(AppStrings.save),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading ?
               Center(child: SizedBox(
                  height: AppDimensions.twentyFive,
                  width: AppDimensions.twentyFive,
                  child: const CircularProgressIndicator(color: AppColors.skyLightColor))):Container(),
            ],
          ),
        ),
      );

    });
  }
}
