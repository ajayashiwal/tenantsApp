import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/appstyle/assets_images.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/tenants_localizations.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../controllers/guest_page_controller.dart';


// ignore: must_be_immutable
class GuestPageView extends StatelessWidget {
  late bool connected = false;
  GuestPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestPageController>(builder: (controller) {

      return Container(
        // color: AppColors.blackColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,
              resizeToAvoidBottomInset: false,
              body: Builder(
                builder: (BuildContext context) {
                  return OfflineBuilder(
                    connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                      connected = connectivity != ConnectivityResult.none;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          child,
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              color:
                              connected ? Colors.transparent : AppColors.blackColor,
                              child: connected
                                  ? Container()
                                  : Padding(
                                padding: AppDimensions.margin10_10_20_20,
                                child: Text(
                                    TenantsLocalizations.of(context)?.find('connectionCheckMessage')??"",
                                    style: AppThemeStyles.white16
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/2.5,
                              child: Stack(
                                children: [
                                  Image.asset(AssetsBase.guestPageBackgroundImage,width: double.infinity,fit: BoxFit.fill),
                                  Positioned(
                                      top: AppDimensions.fifty,
                                      left: 0,right: 0,
                                      child: Image.asset(AssetsBase.appIcon1,height: MediaQuery.of(context).size.height/6,width:  MediaQuery.of(context).size.height/6)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: AppDimensions.margin0_20_20_5,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        // if(controller.appContentModel!=null)
                                        //   if(controller.appContentModel.data!=null)
                                        // ignore: unrelated_type_equality_checks
                                        controller.isLoading ? SizedBox(
                                          height: AppDimensions.twentyFive,
                                          width: AppDimensions.twentyFive,
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: CircularProgressIndicator(color: AppColors.skyLightColor),
                                          ),
                                        ):  Text(controller.appContentModel.data!=null?controller.appContentModel.data!.appScreen![0].text!.label.toString():"", style: AppThemeStyles.blackMedium24),
                                        SizedBox(height: AppDimensions.twenty),
                                        InkWell(
                                          onTap: () {
                                            connected == false
                                                ? Container()
                                                : AppRouteMaps
                                                .goToGeneralInfoPage();
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context).size.width/7,
                                              width: MediaQuery.of(context).size.width/2.2,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                  border: Border.all(
                                                      color: AppColors.blueColor
                                                  ),
                                                  color: AppColors.whiteColor,
                                                  boxShadow:  [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.3), //color of shadow
                                                      spreadRadius: 5, //spread radius
                                                      blurRadius: 7, // blur radius
                                                      offset: const Offset(0, 2),
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        connected == false
                                                            ? Container()
                                                            : AppRouteMaps
                                                            .goToGeneralInfoPage();
                                                      },
                                                      child: Image.asset(AssetsBase.infoIcon, height: AppDimensions.thirty)),
                                                  SizedBox(width: AppDimensions.ten),
                                                  Text(TenantsLocalizations.of(context)?.find(AppStrings.aboutTheCompany)??"",style: AppThemeStyles.blueMedium16),

                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.twenty),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  connected == false
                                                      ? Container()
                                                      : AppRouteMaps.goToLoginPage(AppStrings.tenant);
                                                },
                                                child: Container(
                                                    height: MediaQuery.of(context).size.width/5,
                                                    width: MediaQuery.of(context).size.width/2.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                        border: Border.all(
                                                            color: AppColors.whiteColor
                                                        ),
                                                        color: AppColors.blueColor,
                                                        boxShadow:  [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.3), //color of shadow
                                                            spreadRadius: 5, //spread radius
                                                            blurRadius: 7, // blur radius
                                                            offset: const Offset(0, 2),
                                                          )

                                                        ]
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Image.asset(AssetsBase.tenantsLoginIcon1, height: AppDimensions.thirtyTwo),
                                                        SizedBox(height: AppDimensions.five),
                                                        Text(TenantsLocalizations.of(context)?.find(AppStrings.tenantsLogin)??"",style: AppThemeStyles.whiteMedium16),

                                                      ],
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: AppDimensions.twenty),

                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  connected == false
                                                      ? Container()
                                                      : AppRouteMaps.goToLoginPage(AppStrings.lawayer);
                                                },
                                                child: Container(
                                                    height: MediaQuery.of(context).size.width/5,
                                                    width: MediaQuery.of(context).size.width/2.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                        border: Border.all(
                                                            color: AppColors.whiteColor
                                                        ),
                                                        color: AppColors.blueColor,
                                                        boxShadow:  [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.3), //color of shadow
                                                            spreadRadius: 5, //spread radius
                                                            blurRadius: 7, // blur radius
                                                            offset: const Offset(0, 2),
                                                          )
                                                        ]
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Image.asset(AssetsBase.laywerLoginIcon, height: AppDimensions.thirtyTwo),
                                                        SizedBox(height: AppDimensions.five),
                                                        Text(TenantsLocalizations.of(context)?.find(AppStrings.lawyerLogin)??"",style: AppThemeStyles.whiteMedium16),

                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppDimensions.twenty),
                                        InkWell(
                                          onTap: () {
                                            connected == false
                                                ? Container()
                                                : AppRouteMaps.goToRegistrationPage();
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context).size.width/8,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                  border: Border.all(
                                                      color: AppColors.blueColor
                                                  ),
                                                  color: AppColors.whiteColor,
                                                  boxShadow:  [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.3), //color of shadow
                                                      spreadRadius: 5, //spread radius
                                                      blurRadius: 7, // blur radius
                                                      offset: const Offset(0, 2),
                                                    )
                                                  ]
                                              ),
                                              child: Center(child: Text(TenantsLocalizations.of(context)?.find(AppStrings.registerAsATenant)??"",style: AppThemeStyles.blueMedium16))
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.twenty),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  connected == false
                                                      ? Container()
                                                      : AppRouteMaps.goToJobsPage();
                                                },
                                                child: Container(
                                                    height: MediaQuery.of(context).size.width/8,
                                                    width: MediaQuery.of(context).size.width/2.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                        border: Border.all(
                                                            color: AppColors.whiteColor
                                                        ),
                                                        color: AppColors.blueColor,
                                                        boxShadow:  [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.3), //color of shadow
                                                            spreadRadius: 5, //spread radius
                                                            blurRadius: 7, // blur radius
                                                            offset: const Offset(0, 2),

                                                          )
                                                        ]
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                            AssetsBase.tenantsIcon,
                                                            height: AppDimensions.twentyFour),
                                                        SizedBox(width: AppDimensions.ten),
                                                        Text(
                                                            TenantsLocalizations.of(context)?.find(AppStrings.needed)??"",style: AppThemeStyles.whiteMedium16),

                                                      ],
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: AppDimensions.twenty),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  connected == false
                                                      ? Container()
                                                      : AppRouteMaps.goToContactPage();
                                                },
                                                child: Container(
                                                    height: MediaQuery.of(context).size.width/8,
                                                    width: MediaQuery.of(context).size.width/2.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                        border: Border.all(
                                                            color: AppColors.whiteColor
                                                        ),
                                                        color: AppColors.blueColor,
                                                        boxShadow:  [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.3), //color of shadow
                                                            spreadRadius: 5, //spread radius
                                                            blurRadius: 7, // blur radius
                                                            offset: const Offset(0, 2),
                                                          )
                                                        ]
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Image.asset(AssetsBase.mailIcon, height: AppDimensions.twentyFour,color: AppColors.whiteColor),
                                                        SizedBox(width: AppDimensions.ten),
                                                        Text(TenantsLocalizations.of(context)?.find(AppStrings.contact)??"",style: AppThemeStyles.whiteMedium16),

                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppDimensions.twenty),
                                        InkWell(
                                            onTap: () {
                                              connected == false ? Container() : AppRouteMaps.goToPrivacyPolicyPage();
                                            },
                                            child: Center(child: Text(TenantsLocalizations.of(context)?.find(AppStrings.TermsAndConditionsPrivacyPolicy)??"", style: AppThemeStyles.blueUnderline14))),
                                      ],
                                    )],
                                ),
                              ),
                            )
                          ],
                        ),
                        Platform.isAndroid?(controller.showDialogAndroid==true?
                        vserion(controller,context)
                            :Container()):(controller.showDialogIos==true? vserion(controller,context):Container()),

                        // vserion(controller,context)
                      ],
                    ),

                  );
                },
              )


          ),
        ),
      );
    }
    );
  }

  void version(context) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.lightWhiteColor.withOpacity(0.9),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.ten),
              borderSide: const BorderSide(color: AppColors.lightWhiteColor)

          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                TenantsLocalizations.of(context)!.find(AppStrings.pleaseUpdateTheApplication),
                // style: AppThemeStyles.blackBold16,
                // textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.twenty),
              Padding(
                padding: AppDimensions.margin0_10_10_0,
                child:
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: TenantsLocalizations.of(context)!.find(AppStrings.updateMessage),
                        style: AppThemeStyles.black16,
                        children: const []
                    )),
              ),
              SizedBox(height: AppDimensions.ten),
              const Divider(color: AppColors.lightGreyColor,height: 1),
              // SizedBox(height: AppDimensions.ten),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Center(
                      child: Text(TenantsLocalizations.of(context)?.find(AppStrings.Update)??"",
                          style: AppThemeStyles.blueBold16)),
                ),
              ),
            ],
          )
      ),
    );
  }
}
Container vserion(controller,context){
  return Container(
    color: Colors.transparent,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.lightWhiteColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.grey6Color
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                TenantsLocalizations.of(context)!.find(AppStrings.pleaseUpdateTheApplication),
                style: AppThemeStyles.blackBold16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.twenty),
              Padding(
                padding: AppDimensions.margin0_10_10_0,
                child:
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: TenantsLocalizations.of(context)!.find(AppStrings.updateMessage),
                        style: AppThemeStyles.black16,
                        children: const []
                    )),
              ),
              SizedBox(height: AppDimensions.ten),
              const Divider(color: AppColors.lightGreyColor,height: 1),
              // SizedBox(height: AppDimensions.ten),
              InkWell(
                onTap: () {
                  if(Platform.isAndroid){
                    controller.launchAppStore("https://play.google.com/store/apps/details?id=com.app.tenants");
                  }else{
                    controller.launchAppStore("https://apps.apple.com/us/app/%D7%9E%D7%92%D7%9F-%D7%93%D7%99%D7%99%D7%A8%D7%99%D7%9D/id1637421586?platform=iphone");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Center(
                      child: Text(TenantsLocalizations.of(context)?.find(AppStrings.Update)??"",
                          style: AppThemeStyles.blueBold16)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
//   void checkVersion()async{
//     final newVersion=NewVersion(
//         androidId: "com.example.tenants_shield_project"
//     );
//     final status= await newVersion.getVersionStatus();
//     newVersion.showUpdateDialog(
//         context: context,
//         versionStatus:status!,
//         dialogTitle: "UPDATE!!!",
//         dismissButtonText: "Skip",
//         dialogText: "Please update the app from${status.localVersion}to${status.storeVersion}",
//         dismissAction: (){
//           SystemNavigator.pop();
//         },
//         updateButtonText: "Lets update"
//     );
//     print("Device : ${status.localVersion}");
//     print("Store : ${status.storeVersion}");
//
// }

