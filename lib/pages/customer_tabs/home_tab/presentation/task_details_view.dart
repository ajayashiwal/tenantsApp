

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/task_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class CloseTaskDetails extends StatelessWidget {
  CloseTaskDetails({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<CloseTaskDetailsPageController>()
      ? Get.find<CloseTaskDetailsPageController>()
      : Get.put(CloseTaskDetailsPageController());
  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<CloseTaskDetailsPageController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.whiteColor,
          // appBar: backIconWithWhite(context),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              controller.connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,controller.connected,context);
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        // boxShadow:  [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.3), //color of shadow
                        //     spreadRadius: 3, //spread radius
                        //     blurRadius: 5, // blur radius
                        //     offset: const Offset(0, 2),
                        //   )
                        // ],
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.circular(AppDimensions.thirty),
                        //   bottomRight: Radius.circular(AppDimensions.thirty),
                        // ),
                        image: const DecorationImage(
                            image: AssetImage(AssetsBase.backImage),
                            fit: BoxFit.cover
                        )
                    ),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Stack(
                      //   children: [
                      //     Container(
                      //         height: MediaQuery.of(context).size.height/4,
                      //         width: double.infinity,
                      //         decoration:  BoxDecoration(
                      //             color: AppColors.whiteColor.withOpacity(0.5),
                      //             // boxShadow:  [
                      //             //   BoxShadow(
                      //             //     color: Colors.grey.withOpacity(0.3), //color of shadow
                      //             //     spreadRadius: 3, //spread radius
                      //             //     blurRadius: 5, // blur radius
                      //             //     offset: const Offset(0, 2),
                      //             //   )
                      //             // ],
                      //             // borderRadius: BorderRadius.only(
                      //             //   bottomLeft: Radius.circular(AppDimensions.thirty),
                      //             //   bottomRight: Radius.circular(AppDimensions.thirty),
                      //             // ),
                      //           image: const DecorationImage(
                      //             image: AssetImage(AssetsBase.backImage),
                      //             fit: BoxFit.cover
                      //           )
                      //         ),),
                      //         // child: Image.asset(AssetsBase.homeBackgroundIcon,)),
                      //
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30,bottom: 5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: ()  {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20,left: 10,top: 10,bottom: 10),
                                  child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon),height: 20,),
                                ),
                              ),
                            ),
                            Container(
                              height: AppDimensions.hundred,
                              // width: AppDimensions.sixty,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                border: Border.all(color: const Color(0xFFE9ECEF)),
                                borderRadius: BorderRadius.circular(AppDimensions.ten),
                                boxShadow:  [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3), //color of shadow
                                    spreadRadius: 3, //spread radius
                                    blurRadius: 5, // blur radius
                                    offset: const Offset(0, 2),
                                  )
                                ],
                                // borderRadius: BorderRadius.only(
                                //   bottomLeft: Radius.circular(AppDimensions.thirty),
                                //   bottomRight: Radius.circular(AppDimensions.thirty),
                                // ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: controller.type=="lawyers"?controller.lawyerData!.profileImage.toString():controller.contractorsData!.image.toString(),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: AppColors.blueColor),
                                      )),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.ten),
                      Text(controller.type=="lawyers"?controller.lawyerData!.officeInfo!.name.toString():controller.contractorsData!.companyName.toString(),style: AppThemeStyles.blackBold18),
                      Text(controller.type=="lawyers"?controller.lawyerData!.officeInfo!.subTitle.toString():controller.contractorsData!.subTitle.toString(),style: AppThemeStyles.black16),
                      SizedBox(height: AppDimensions.ten),
                      // if(controller.appContentModel.data!=null)
                      // if(controller.appContentModel.data!.generalSetting!.stars.toString()!=null)
                      // controller.isLoading1 ? const SizedBox(
                      //   height: 40,
                      //   width: 40,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: CircularProgressIndicator(color: AppColors.skyLightColor),
                      //   ),
                      // ):
                      // Container(
                      //     height: 40,
                      //     child: Image.network(controller.appContentModel.data!.generalSetting!.stars.toString())),
                      SizedBox(
                          height: 40,
                          child: Image.network(controller.starImage.toString())),


                      // SizedBox(height: AppDimensions.ten),
                      SizedBox(height: AppDimensions.twenty),
                      controller.lawyerTenantType!="laawyer" &&  controller.mainType=="taskInProgress"? Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: InkWell(
                            onTap: ()async{
                              controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString()) || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?  controller.competeTaskApi(
                                  controller.projectTaskDetailModel.data!.projectId.toString(),
                                  controller.projectTaskDetailModel.data!.taskId.toString(),
                                  controller.projectTaskDetailModel.data!.id.toString(),
                                  "1",
                                  controller.contractorAndLawyerId.toString()
                              ):unSelectedDialogue(controller);
                            },
                            child:  Container(
                                height: AppDimensions.fifty,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppDimensions.ten),
                                  color: controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString()) || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null|| controller.projectTaskDetailModel.data!.completeStatus == null? AppColors.skyHighLightColor:AppColors.lightGreenColor,
                                  boxShadow:  [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2), //color of shadow
                                      spreadRadius: 4, //spread radius
                                      blurRadius: 6, // blur radius
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  border: Border.all(
                                      color: AppColors.whiteColor
                                  ),
                                ),
                                child: Padding(
                                  padding: AppDimensions.margin0_20_20_0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?Container(): const Icon(Icons.check_circle_outline,color: AppColors.whiteColor),
                                      controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  ||  controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?Container():const Spacer(),
                                      controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  ||  controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?Text(TenantsLocalizations.of(context)!.find(AppStrings.chooseMe),
                                          style:
                                          controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?
                                          AppThemeStyles.blue20:AppThemeStyles.white20):
                                      Text(TenantsLocalizations.of(context)!.find(AppStrings.myChoice),
                                          style:
                                          controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?
                                          AppThemeStyles.blue20:AppThemeStyles.white20),
                                      controller.contractorAndLawyerId.toString()!=(controller.type=="contractors"?controller.projectTaskDetailModel.data!.completeStatus?.contractorId.toString():controller.projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  || controller.projectTaskDetailModel.data!.completeStatus?.status==0 || controller.projectTaskDetailModel.data!.completeStatus == null?Container():const Spacer(),
                                    ],
                                  ),
                                )
                            )
                        ),
                      ):Container(),
                      controller.mainType=="taskInProgress"? SizedBox(height: AppDimensions.twenty):Container(),
                      controller.type=="lawyers"? controller.lawyerData!.officeInfo!.website==null?Container():
                      Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(TenantsLocalizations.of(context)!.find(AppStrings.webSite),style: AppThemeStyles.blackBold14),
                                  SizedBox(height: AppDimensions.five),
                                  Text(controller.lawyerData!.officeInfo!.website.toString(),style: AppThemeStyles.blueBold14),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: ()async{
                                  final url=controller.type=="lawyers"?controller.lawyerData!.officeInfo!.website.toString():controller.contractorsData!.website.toString();
                                  // ignore: deprecated_member_usex, deprecated_member_use
                                  if(await canLaunch(url)){
                                    // ignore: deprecated_member_use
                                    await launch(url);
                                  }else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Image.asset(AssetsBase.webSiteBlueIcon,height: AppDimensions.thirtyFive,width: AppDimensions.thirtyFive)),
                          ],
                        ),
                      ):controller.contractorsData!.website==null?Container(): Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(TenantsLocalizations.of(context)!.find(AppStrings.webSite),style: AppThemeStyles.blackBold14),
                                  SizedBox(height: AppDimensions.five),
                                  Text(controller.contractorsData!.website.toString(),style: AppThemeStyles.blueBold14),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: ()async{
                                  final url=controller.type=="lawyers"?controller.lawyerData!.officeInfo!.website.toString():controller.contractorsData!.website.toString();
                                  // ignore: deprecated_member_usex, deprecated_member_use
                                  if(await canLaunch(url)){
                                    // ignore: deprecated_member_use
                                    await launch(url);
                                  }else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Image.asset(AssetsBase.webSiteBlueIcon,height: AppDimensions.thirtyFive,width: AppDimensions.thirtyFive)),
                          ],
                        ),
                      ),
                      // controller.lawyerData==null?Container():  controller.lawyerData!.officeInfo!.website==null?Container():
                      controller.type=="lawyers"? controller.lawyerData!.officeInfo!.website==null?Container():
                      SizedBox(height: AppDimensions.ten):controller.contractorsData!.website==null?Container():SizedBox(height: AppDimensions.ten),

                      // controller.lawyerData==null?Container(): controller.lawyerData!.officeInfo!.website==null?Container():
                      controller.type=="lawyers"? controller.lawyerData!.officeInfo!.website==null?Container():

                      Divider(color: Colors.grey.shade400):controller.contractorsData!.website==null?Container():Divider(color: Colors.grey.shade400),
                      SizedBox(height: AppDimensions.ten),
                      Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(TenantsLocalizations.of(context)!.find(AppStrings.email),style: AppThemeStyles.blackBold14),
                                SizedBox(height: AppDimensions.five),
                                Text(controller.type=="lawyers"?controller.lawyerData!.officeInfo!.email.toString():controller.contractorsData!.officeEmail.toString(),style: AppThemeStyles.blueBold14),
                              ],
                            ),
                            InkWell(
                                onTap: () async {
                                  // ignore: deprecated_member_use
                                  launch('mailto:${controller.type=="lawyers"?controller.lawyerData!.officeInfo!.email.toString():controller.contractorsData!.officeEmail.toString()}');

                                },
                                child: Image.asset(AssetsBase.emailBlueIcon,height: AppDimensions.thirtyFive,width: AppDimensions.thirtyFive)),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.ten),
                      Divider(color: Colors.grey.shade400),
                      SizedBox(height: AppDimensions.ten),
                      Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(TenantsLocalizations.of(context)!.find(AppStrings.officePhone),style: AppThemeStyles.blackBold14),
                                SizedBox(height: AppDimensions.five),
                                Text(controller.type=="lawyers"?controller.lawyerData!.officeInfo!.phone.toString():controller.contractorsData!.officePhone.toString(),style: AppThemeStyles.blueBold14),
                              ],
                            ),
                            InkWell(
                                onTap: (){
                                  _makePhoneCall("tel:${controller.type=="lawyers"?controller.lawyerData!.officeInfo!.phone.toString():controller.contractorsData!.officePhone.toString()}");
                                },
                                child: Image.asset(AssetsBase.callIcon,height: AppDimensions.thirtyFive,width: AppDimensions.thirtyFive)),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.ten),
                      Divider(color: Colors.grey.shade400),
                      SizedBox(height: AppDimensions.ten),
                      Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(TenantsLocalizations.of(context)!.find(AppStrings.officeAddress),style: AppThemeStyles.blackBold14),
                                SizedBox(height: AppDimensions.five),
                                Text(controller.type=="lawyers"?controller.lawyerData!.officeInfo!.address.toString():controller.contractorsData!.officeAddress.toString(),style: AppThemeStyles.blueBold14),
                              ],
                            ),
                            InkWell(
                                onTap: ()async{
                                  List<Location> locations = await locationFromAddress(controller.contractorsData!.officeAddress.toString()=="null"?"":controller.type=="lawyers"?controller.lawyerData!.officeInfo!.address.toString():controller.contractorsData!.officeAddress.toString());
                                  launchWaze(locations.first.latitude,locations.first.longitude);
                                },
                                child: Image.asset(AssetsBase.addressBlueIcon,height: AppDimensions.thirtyFive,width: AppDimensions.thirtyFive)),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.ten),
                      Divider(color: Colors.grey.shade400),
                      SizedBox(height: AppDimensions.ten),

                      // controller.lawyerData==null?Container(): controller.lawyerData!.officeInfo!.moreInfo==null?Container():
                      controller.type=="lawyers"? controller.lawyerData!.officeInfo!.moreInfo==null?Container():

                      Padding(
                        padding: AppDimensions.margin0_20_20_20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfo),style: AppThemeStyles.blackBold20),
                            // SizedBox(height: AppDimensions.twenty),
                            HtmlWidget(
                              controller.lawyerData!.officeInfo!.moreInfo.toString(),
                              textStyle: AppThemeStyles.blackHeight14,

                            ),
                          ],
                        ),
                      ):controller.contractorsData!.moreInfo==null?Container():  Padding(
                        padding: AppDimensions.margin0_20_20_20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfo),style: AppThemeStyles.blackBold20),
                            // SizedBox(height: AppDimensions.twenty),
                            HtmlWidget(
                              controller.contractorsData!.moreInfo.toString(),
                              textStyle: AppThemeStyles.blackHeight14,
                            ),],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )
      );

    });

  }

  void chooseDialogue() {
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
                  TenantsLocalizations.of(Get.context!)!.find(AppStrings.choosingAttorney),
                  style: AppThemeStyles.blackBold16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.twenty),
                Padding(
                  padding: AppDimensions.margin0_10_10_0,
                  child:
                  RichText(
                      textAlign: TextAlign.center,
                      text:  TextSpan(
                        text: TenantsLocalizations.of(Get.context!)!.find(AppStrings.choosingLawyer),
                        style: AppThemeStyles.black16,

                      )),
                ),

                SizedBox(height: AppDimensions.ten),
                Column(
                  children: [
                    Container(
                        height:AppDimensions.one,
                        width: double.infinity,
                        color: Colors.grey.shade400
                    ),
                    Padding(
                      padding: AppDimensions.padding20,
                      child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Center(
                            child: Text(
                                TenantsLocalizations.of(Get.context!)!.find(AppStrings.close),
                                style: AppThemeStyles.blueBold16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
  void unSelectedDialogue(controller) {
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
                  TenantsLocalizations.of(Get.context!)!.find(AppStrings.deselect),
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
                        text: TenantsLocalizations.of(Get.context!)!.find(AppStrings.unSelectMessage),
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
                            onTap: (){
                              controller.competeTaskApi(
                                  controller.projectTaskDetailModel.data!.projectId.toString(),
                                  controller.projectTaskDetailModel.data!.taskId.toString(),
                                  controller.projectTaskDetailModel.data!.id.toString(),
                                  "0",
                                  controller.contractorAndLawyerId.toString()
                              );
                              Get.back(result: "Yes");
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
  void launchWaze(double lat, double lng) async {
    var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
    try {
      bool launched =
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        // ignore: deprecated_member_use
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      // ignore: deprecated_member_use
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

}

