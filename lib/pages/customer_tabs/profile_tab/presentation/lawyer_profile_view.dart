import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/lawyer_profile_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class LawyerProfileView extends StatelessWidget {
  late  bool connected=false;
  LawyerProfileView({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<LawyerProfileController>()
      ? Get.find<LawyerProfileController>()
      : Get.put(LawyerProfileController());
  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<LawyerProfileController>(builder: (controller) {
      controller.getProfile();
      return  Scaffold(
          body:OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/3.8,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        color: AppColors.skyHighLightColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimensions.thirty),
                          bottomRight: Radius.circular(AppDimensions.thirty),
                        )
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        controller.imagesUrl!="null" && controller.imagesUrl!=""? ClipRRect(
                          borderRadius:  BorderRadius.all(
                              Radius.circular(AppDimensions.fifty)),
                          child: Container(
                            height:AppDimensions.hundred,
                            width: AppDimensions.hundred,
                            color: AppColors.lightGreyColor.withOpacity(0.2),
                            child: CachedNetworkImage(
                              imageUrl: controller.imagesUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: AppColors.blueColor)),
                            ),
                          ),
                        ):CircleAvatar(
                          radius: AppDimensions.fifty,
                          backgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                          child:  CircleAvatar(
                              radius: AppDimensions.fortyEight,
                              backgroundColor: Colors.transparent,
                              // fileOfImage == null ?(widget.image!=null? NetworkImage(widget.image!) as ImageProvider:AssetImage("assets/images/image 9.png")) : FileImage(fileOfImage!) as ImageProvider
                              // ignore: unnecessary_null_comparison
                              backgroundImage:  const AssetImage(AssetsBase.carbonUserAvatarIcon)),
                        ),
                        SizedBox(height: AppDimensions.ten),
                        Text(controller.title.toString(),style: AppThemeStyles.blackBold18),
                        SizedBox(height: AppDimensions.five),
                        Text(controller.subTitle.toString(),style: AppThemeStyles.black18),
                        SizedBox(height: AppDimensions.ten),
                      ],
                    ),
                  ),


                  InkWell(
                    onTap: () async {
                      var result =  connected == false
                          ? Container():  AppRouteMaps.goToUpdateLawyerProfileDetailsPage();
                      if(result=="Yes"){
                        controller.getProfile();
                      }
                    },

                    child: Padding(
                      padding: AppDimensions.padding20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.updatePersonalDetails),style: AppThemeStyles.black16),
                          Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.forwardIcon),color: AppColors.skyLightColor,height: AppDimensions.twenty),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),
                  InkWell(
                    onTap: (){
                      connected == false
                          ? Container(): AppRouteMaps.goToUpdateOfficeProfileDetailsPage();
                    },
                    child: Padding(
                      padding: AppDimensions.padding20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.updateOfficeDetails),style: AppThemeStyles.black16),
                          Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.forwardIcon),color: AppColors.skyLightColor,height: AppDimensions.twenty),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),
                  InkWell(
                    onTap: (){
                      connected == false
                          ? Container():  AppRouteMaps.goToPrivacyPolicyPage();
                    },
                    child: Padding(
                      padding: AppDimensions.padding20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.termsPrivacyPolicy),style: AppThemeStyles.black16),
                          Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.forwardIcon),color: AppColors.skyLightColor,height: AppDimensions.twenty),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),
                  InkWell(
                    onTap: ()async{
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(AppStrings.projectId, "");
                      connected == false
                          ? Container():  projectCodePopUPDialogs(
                        // ignore: use_build_context_synchronously
                        TenantsLocalizations.of(context)!.find(AppStrings.logOutOfTheApp),
                        // ignore: use_build_context_synchronously
                        TenantsLocalizations.of(context)!.find(AppStrings.logoutMessage),
                      );
                    },
                    child: Padding(
                      padding: AppDimensions.padding20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.logOutOfTheApp),style: AppThemeStyles.red16),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.applicationVersion.toString(),style: AppThemeStyles.black16),
                      Text(TenantsLocalizations.of(context)!.find(AppStrings.version),style: AppThemeStyles.black16),
                    ],
                  ),
                  SizedBox(height: AppDimensions.twenty),
                ],
              ),
            ),
          )
      );
    });

  }
  void projectCodePopUPDialogs(String title,String message) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.lightWhiteColor.withOpacity(0.9),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.ten),
              borderSide: const BorderSide(color: AppColors.lightWhiteColor)

          ),
          content: Padding(
            padding: AppDimensions.marginTopTwenty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppThemeStyles.redBold16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.twenty),
                Padding(
                  padding: AppDimensions.margin0_10_10_0,
                  child:
                  RichText(
                      textAlign: TextAlign.center,
                      text:  TextSpan(
                        text: message,
                        style: AppThemeStyles.black16,

                      )),
                ),

                SizedBox(height: AppDimensions.ten),
                Column(
                  children: [
                    Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.shade400
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: AppDimensions.padding10,
                              child: Center(
                                  child: Text(
                                      TenantsLocalizations.of(Get.context!)!.find(AppStrings.no),
                                      style: AppThemeStyles.blueBold16)),
                            ),
                          ),
                        ),
                        Container(
                            height: AppDimensions.fifty,
                            width: AppDimensions.one,
                            color: Colors.grey.shade400
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async{
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setString(AppStrings.token,"");
                              SharedPreferences.getInstance().then((value) {
                                final authToken = value.getString(AppStrings.token);
                                if (kDebugMode) {
                                  print("Auth Token$authToken");
                                }});
                              AppRouteMaps.goToGuestPage();

                            },
                            child: Padding(
                              padding: AppDimensions.padding10,
                              child: Center(
                                  child: Text(
                                      TenantsLocalizations.of(Get.context!)!.find(AppStrings.yes),
                                      style: AppThemeStyles.blueBold16)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
