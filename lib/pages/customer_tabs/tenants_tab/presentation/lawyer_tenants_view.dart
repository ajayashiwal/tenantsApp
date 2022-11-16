import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/assets_images.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/controllers/lawyer_tenants_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class LawyerTenantsPageView extends StatelessWidget{
  late  bool connected=false;
  LawyerTenantsPageView({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<LawyerTenantsPageController>()
      ? Get.find<LawyerTenantsPageController>()
      : Get.put(LawyerTenantsPageController());

  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<LawyerTenantsPageController>(builder: (controller) {
      return  Scaffold(
          appBar: title(TenantsLocalizations.of(context)!.find(AppStrings.tenantsTab),context),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: Stack(
                  children: [
                    Padding(
                      padding: AppDimensions.marginTopTwenty,
                      child: Column(
                        children: [
                          Padding(
                            padding:AppDimensions.margin0_20_20_0,
                            child: Container(
                              height: AppDimensions.forty,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppDimensions.ten),
                                  color: AppColors.grey6Color
                              ),
                              child: TextFormField(
                                controller: controller.searchController,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v){
                                  controller.searchTextAPi(v);
                                },
                                decoration:  InputDecoration(
                                    contentPadding:  EdgeInsets.symmetric(horizontal: AppDimensions.twelve,vertical:AppDimensions.six),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    hintText: TenantsLocalizations.of(context)!.find(AppStrings.search),
                                    prefixIcon: const Icon(Icons.search_outlined,color:AppColors.lightGreyColor),
                                    hintStyle: const TextStyle(
                                        color: AppColors.lightGreyColor
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.ten),

                          // ignore: unnecessary_null_comparison
                          if (controller.lawyerTenantsModel != null)
                            if (controller.lawyerTenantsModel.data != null)
                              Expanded(
                                child: RefreshIndicator(
                                  color: AppColors.blueColor,
                                  onRefresh: () async {
                                    await Future.delayed(const Duration(seconds: 2));
                                    controller.userDetailApiWithOutLoading("");
                                  },
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // controller: controller.scrollController,
                                      itemCount: controller.lawyerTenantsModel.data!.length,
                                      itemBuilder: (context,i){
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,

                                                  children: [
                                                    Row(
                                                      children: [
                                                        (controller.lawyerTenantsModel.data![i].profileImage!=null && controller.lawyerTenantsModel.data![i].profileImage!="")? ClipRRect(
                                                          borderRadius:  BorderRadius.all(
                                                              Radius.circular(AppDimensions.fifty)),
                                                          child: Container(
                                                            height: AppDimensions.fifty,
                                                            width: AppDimensions.fifty,
                                                            color: AppColors.lightGreyColor.withOpacity(0.2),
                                                            child: CachedNetworkImage(
                                                              imageUrl: controller.lawyerTenantsModel.data![i].profileImage.toString(),
                                                              progressIndicatorBuilder:
                                                                  (context, url, downloadProgress) => Center(
                                                                  child: SizedBox(
                                                                    height: AppDimensions.twenty,width: AppDimensions.twenty,
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress.progress,
                                                                        strokeWidth: 2,
                                                                        color: AppColors.blueColor),
                                                                  )),
                                                            ),
                                                          ),
                                                        ): CircleAvatar(
                                                          radius: AppDimensions.twentyFive,
                                                          backgroundColor: AppColors.grey6Color,
                                                          backgroundImage: const AssetImage(AssetsBase.carbonUserAvatarIcon),
                                                        ),
                                                        SizedBox(width: AppDimensions.ten),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(controller.lawyerTenantsModel.data![i].lastName.toString() ,style: AppThemeStyles.black14),
                                                                const SizedBox(width: 5),
                                                                Text(controller.lawyerTenantsModel.data![i].firstName.toString() ,style: AppThemeStyles.black14),


                                                              ],
                                                            ),
                                                            Row(
                                                             children: [
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):Text(TenantsLocalizations.of(context)!.find('bui'),style: AppThemeStyles.blackBold14),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):SizedBox(width: AppDimensions.two),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""): Text(controller.lawyerTenantsModel.data![i].buildingNumber.toString(),style: AppThemeStyles.blackBold14),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):SizedBox(width: AppDimensions.two),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):Text(TenantsLocalizations.of(context)!.find('apr'),style: AppThemeStyles.blackBold14),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):SizedBox(width: AppDimensions.two),
                                                               // ignore: unnecessary_null_comparison
                                                               controller.lawyerTenantsModel.data![i].buildingNumber==null?const Text(""):Text(controller.lawyerTenantsModel.data![i].apartmentNumber.toString(),style: AppThemeStyles.blackBold14,overflow: TextOverflow.ellipsis),

                                                             ],
                                                                ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Container(
                                                          height: 40,
                                                          // width: AppDimensions.hundred,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(AppDimensions.forty)
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.end,

                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 5),
                                                                child: controller.lawyerTenantsModel.data![i].representative==0?Container(): Text("נציג דיירים",style: AppThemeStyles.greenBold12),
                                                              ),
                                                              SizedBox(width: AppDimensions.five),
                                                              InkWell(
                                                                  onTap:(){
                                                                    connected == false ? Container(): _makePhoneCall("tel:${"972${controller.lawyerTenantsModel.data![i].phone.toString().replaceFirst(RegExp(r'^0+'), "")}"}");
                                                                    },
                                                                  child: Image.asset(AssetsBase.callIcon)),
                                                              SizedBox(width: AppDimensions.ten),
                                                              InkWell(
                                                                  onTap: (){
                                                                    connected == false ? Container():whatsapp("972${controller.lawyerTenantsModel.data![i].phone.toString().replaceFirst(RegExp(r'^0+'), "")}");
                                                                  },
                                                                  child: Image.asset(AssetsBase.webSiteIcon)),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                        ],
                      ),
                    ),
                    controller.isLoading ?
                    Center(
                      child: SizedBox(
                          height: AppDimensions.twentyFive,
                          width: AppDimensions.twentyFive,
                          child: const CircularProgressIndicator(color: AppColors.skyLightColor)),
                    ):Container()
                  ],
                ),
          ));

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
