import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/laywer_contact_info_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class LawyerContactInfoView extends StatelessWidget {
  late  bool connected=false;
  LawyerContactInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerContactInfoPageController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: backIcon(context),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height/3.5,
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
                        // const Spacer(),
                        (controller.profile!=null && controller.profile!=""? ClipRRect(
                          borderRadius:  BorderRadius.all(Radius.circular(AppDimensions.fifty)),
                          child: Container(
                            height: AppDimensions.hundred,
                            width: AppDimensions.hundred,
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: controller.profile.toString(),
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
                        )),
                        SizedBox(height: AppDimensions.ten),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(controller.lastName,style: AppThemeStyles.blackBold18),
                            SizedBox(width: AppDimensions.five),
                            Text(controller.firstName,style: AppThemeStyles.blackBold18),
                          ],
                        ),
                        Text(controller.type.toString(),style: AppThemeStyles.black16),
                        SizedBox(height: AppDimensions.twenty),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  (controller.type.toString()==AppStrings.tenantRepresentative || controller.type.toString()==controller.role)? controller.phoneNo.toString()==""?Container():Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TenantsLocalizations.of(context)!.find(AppStrings.onlyPhone),style: AppThemeStyles.blackBold14),
                              SizedBox(height: AppDimensions.five),
                              Text(controller.phoneNo.toString(),style: AppThemeStyles.blue14),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              connected == false ? Container(): _makePhoneCall("tel:${"972${controller.phoneNo.toString().replaceFirst(RegExp(r'^0+'), "")}"}");

                              // _makePhoneCall("tel:${controller.phoneNo}");
                            },
                            child: Image.asset(AssetsBase.callIcon,height: 43,width: 43)),
                        SizedBox(width: AppDimensions.five),
                        InkWell(
                            onTap: (){
                              connected == false ? Container():whatsapp("972${controller.phoneNo.toString().replaceFirst(RegExp(r'^0+'), "")}");

                            },
                            child: Image.asset(AssetsBase.webSiteIcon,height: 43,width: 43)),
                      ],
                    ),
                  ):controller.website.toString()==""?Container():Padding(
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
                              Text(controller.website,style: AppThemeStyles.blue14),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () async{
                              // _launchEmail(controller.website);
                              final url=controller.website;
                              // ignore: deprecated_member_use
                              if(await canLaunch(url)){
                                // ignore: deprecated_member_use
                                await launch(url);
                              }else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Image.asset(AssetsBase.webSiteBlueIcon,height: 43,width: 43)),
                      ],
                    ),
                  ),

                  controller.website==""?Container():SizedBox(height: AppDimensions.ten),
                   controller.website==""?Container(): Divider(color: Colors.grey.shade400),
                  SizedBox(height: AppDimensions.ten),
                  controller.type.toString()==controller.role || controller.website!=""  ?  controller.faxNo.toString() ==""? Container(): SizedBox(height: AppDimensions.ten):Container(),
                  controller.type.toString()==controller.role || controller.website!="" ?controller.faxNo.toString()=="" ?Container():Divider(color: Colors.grey.shade400):Container(),
                  controller.type.toString()==controller.role || controller.website!="" ?controller.faxNo.toString()=="" ?Container():SizedBox(height: AppDimensions.ten):Container(),
                  (controller.type.toString()==AppStrings.tenantRepresentative || controller.type.toString()==controller.role)?controller.faxNo.toString()==""?Container():Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.fax),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.faxNo.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                      ],
                    ),
                  ):
                  controller.type.toString()=="יו”ר וועד הקבוצה"?controller.phoneNo.toString()==""?Container():Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.officePhone),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.phoneNo.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  connected == false ? Container():whatsapp("972${controller.phoneNo.toString().replaceFirst(RegExp(r'^0+'), "")}");
                                },
                                child: Image.asset(AssetsBase.webSiteIcon,height: 43,width: 43)),
                            SizedBox(width: AppDimensions.ten),
                            InkWell(
                                onTap: (){
                                  connected == false ? Container(): _makePhoneCall("tel:${"972${controller.phoneNo.toString().replaceFirst(RegExp(r'^0+'), "")}"}");

                                  // _makePhoneCall("tel:${controller.phoneNo}");
                                },
                                child: Image.asset(AssetsBase.callIcon,height: 43,width: 43)),
                          ],
                        ),
                      ],
                    ),
                  ):controller.phoneNo.toString()==""?Container():Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.onlyPhone),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.phoneNo.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                        InkWell(
                            onTap: (){
                              connected == false ? Container(): _makePhoneCall("tel:${"972${controller.phoneNo.toString().replaceFirst(RegExp(r'^0+'), "")}"}");

                              // _makePhoneCall("tel:${controller.phoneNo}");
                            },
                            child: Image.asset(AssetsBase.callIcon,height: 43,width: 43)),
                      ],
                    ),
                  ),

                  controller.email.toString()==""?Container():  SizedBox(height: AppDimensions.ten),
                  controller.email.toString()==""?Container(): Divider(color: Colors.grey.shade400),
                  controller.email.toString()==""?Container():SizedBox(height: AppDimensions.ten),
                  controller.email.toString()==""?Container(): Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.email),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.email.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                        InkWell(
                            onTap: (){
                              // ignore: deprecated_member_use
                              launch('mailto:${controller.email}');
                            },
                            child: Image.asset(AssetsBase.emailBlueIcon,height: 43,width: 43)),
                      ],
                    ),
                  ),

                  controller.type.toString()=="יו”ר וועד הקבוצה"?controller.phoneNo.toString()==""?Container(): SizedBox(height: AppDimensions.ten):Container(),
                  controller.type.toString()=="יו”ר וועד הקבוצה"?controller.phoneNo.toString()==""?Container():Divider(color: Colors.grey.shade400):Container(),
                  controller.type.toString()=="יו”ר וועד הקבוצה"?controller.phoneNo.toString()==""?Container():SizedBox(height: AppDimensions.ten):Container(),
                  controller.type.toString()=="יו”ר וועד הקבוצה"?controller.faxNo.toString()==""?Container():Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.fax),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.faxNo.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                      ],
                    ),
                  ):Container(),
                  controller.phoneNo.toString()==""?Container(): SizedBox(height: AppDimensions.ten),
                  controller.phoneNo.toString()==""?Container(): Divider(color: Colors.grey.shade400),
                  controller.phoneNo.toString()==""?Container(): SizedBox(height: AppDimensions.ten),
                  controller.workAddress.toString()=="null"?Container(): Padding(
                    padding: AppDimensions.margin0_20_20_0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TenantsLocalizations.of(context)!.find(AppStrings.workAddress),style: AppThemeStyles.blackBold14),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.workAddress=="null"?"":controller.workAddress.toString(),style: AppThemeStyles.blue14),
                          ],
                        ),
                        InkWell(
                            onTap: () async{
                              List<Location> locations = await locationFromAddress(controller.workAddress=="null"?"":controller.workAddress.toString());
                              launchWaze(locations.first.latitude,locations.first.longitude);
                            },
                            child: Image.asset(AssetsBase.addressBlueIcon,height: 43,width: 43)),
                      ],
                    ),
                  ),
                  controller.workAddress.toString()=="null"?Container():  SizedBox(height: AppDimensions.ten),
                  controller.workAddress.toString()=="null"?Container(): Divider(color: Colors.grey.shade400),
                  controller.workAddress.toString()=="null"?Container(): SizedBox(height: AppDimensions.ten),
                  (controller.type.toString()==AppStrings.tenantRepresentative || controller.type.toString()==controller.role) ?Container(): controller.moreInfo.toString()==""?Container(): Padding(
                    padding: AppDimensions.margin0_20_20_20,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfo),style: AppThemeStyles.blackBold20),
                          SizedBox(height: AppDimensions.twenty),
                          HtmlWidget(
                            controller.moreInfo.toString(),
                            textStyle: AppThemeStyles.blackHeight14,

                          )

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
      );

    });
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
  whatsapp(String contact) async{
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }


}
