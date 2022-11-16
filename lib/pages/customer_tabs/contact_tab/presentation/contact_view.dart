import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/controllers/contact_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class ContactListPageView extends StatelessWidget {
  late  bool connected=false;
  ContactListPageView({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<ContactListPageController>()
      ? Get.find<ContactListPageController>()
      : Get.put(ContactListPageController());
  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<ContactListPageController>(builder: (controller) {
      return  Scaffold(
          appBar:title(TenantsLocalizations.of(context)!.find(AppStrings.contactsTab),context),
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
                        padding:  AppDimensions.margin0_20_20_0,
                        child: Container(
                          height: AppDimensions.forty,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimensions.ten),
                              color: AppColors.grey6Color
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            decoration:  InputDecoration(
                                contentPadding:  EdgeInsets.symmetric(horizontal: AppDimensions.twelve,vertical:AppDimensions.six),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: TenantsLocalizations.of(context)!.find(AppStrings.search),
                                prefixIcon: const Icon(Icons.search_outlined,color: AppColors.lightGreyColor),
                                hintStyle: const TextStyle(
                                    color: AppColors.lightGreyColor
                                )
                            ),
                            onFieldSubmitted: (v){
                              controller.contactSearchTextAPi(v);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.ten),
                      // ignore: unnecessary_null_comparison
                        if (controller.contactListingModel.data != null)
                          if (controller.contactListingModel.data!.representatives!= null)
                            Expanded(
                              child: RefreshIndicator(
                                color: AppColors.blueColor,
                                onRefresh: () async {
                                  await Future.delayed(const Duration(seconds: 2));
                                  controller.contactListingApiWithLoading("");
                                },
                                child: ListView(
                                  shrinkWrap: true,
                                  controller: controller.scrollController,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        controller: controller.scrollController,
                                        itemCount: controller.contactListingModel.data!.representatives!.length,
                                        itemBuilder: (context,i){
                                          return InkWell(
                                            onTap: (){
                                              connected == false
                                                  ? Container(): AppRouteMaps.goToContactInfoPage
                                                (
                                                  controller.contactListingModel,
                                                  controller.contactListingModel.data!.representatives![i].id.toString(),
                                                  AppStrings.tenantRepresentative
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:  const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      (controller.contactListingModel.data!.representatives![i].profileImage!=null && controller.contactListingModel.data!.representatives![i].profileImage!="")? ClipRRect(
                                                        borderRadius:  BorderRadius.all(
                                                            Radius.circular(AppDimensions.fifty)),
                                                        child: Container(
                                                          height: AppDimensions.fifty,
                                                          width: AppDimensions.fifty,
                                                          color: AppColors.lightGreyColor.withOpacity(0.2),
                                                          child: CachedNetworkImage(
                                                            imageUrl: controller.contactListingModel.data!.representatives![i].profileImage.toString(),
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
                                                      SizedBox(width: AppDimensions.twenty),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(controller.contactListingModel.data!.representatives![i].lastName.toString(),style: AppThemeStyles.black14),
                                                              const SizedBox(width: 5),
                                                              Text(controller.contactListingModel.data!.representatives![i].firstName.toString(),style: AppThemeStyles.black14),
                                                            ],
                                                          ),
                                                          Text("נציג דיירים",style: AppThemeStyles.blackBold14),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor,)

                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          );

                                        }),
                                    // contacts listing
                                    // ignore: unnecessary_null_comparison
                                    if (controller.contactListingModel.data != null)
                                      if (controller.contactListingModel.data!.contacts!= null)
                                        ListView.builder(
                                            shrinkWrap: true,
                                            controller: controller.scrollController,
                                            itemCount: controller.contactListingModel.data!.contacts!.length,
                                            itemBuilder: (context,i){
                                              return InkWell(
                                                onTap: (){
                                                  connected == false
                                                      ? Container():AppRouteMaps.goToContactInfoPage
                                                    (
                                                      controller.contactListingModel,
                                                      controller.contactListingModel.data!.contacts![i].id.toString(),
                                                      AppStrings.selectContacts
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          (controller.contactListingModel.data!.contacts![i].image!=null && controller.contactListingModel.data!.contacts![i].image!="")? ClipRRect(
                                                            borderRadius:  BorderRadius.all(
                                                                Radius.circular(AppDimensions.fifty)),
                                                            child: Container(
                                                              height: AppDimensions.fifty,
                                                              width: AppDimensions.fifty,
                                                              color: AppColors.lightGreyColor.withOpacity(0.2),
                                                              child: CachedNetworkImage(
                                                                imageUrl: controller.contactListingModel.data!.contacts![i].image.toString(),
                                                                progressIndicatorBuilder:
                                                                    (context, url, downloadProgress) => Center(
                                                                    child: SizedBox(
                                                                      height: 20,width: 20,
                                                                      child: CircularProgressIndicator(
                                                                          value: downloadProgress.progress,
                                                                          strokeWidth: 2,
                                                                          color: AppColors.blueColor),
                                                                    )),
                                                              ),
                                                            ),
                                                          ):
                                                          CircleAvatar(
                                                            radius: AppDimensions.twentyFive,
                                                            backgroundColor: AppColors.grey6Color,
                                                            backgroundImage: const AssetImage(AssetsBase.carbonUserAvatarIcon),
                                                          ),
                                                          SizedBox(width: AppDimensions.twenty),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(controller.contactListingModel.data!.contacts![i].name.toString(),style: AppThemeStyles.black14),
                                                              Text(controller.contactListingModel.data!.contacts![i].role.toString(),style: AppThemeStyles.blackBold14),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor,)

                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                              );

                                            }),
                                    // const Divider(),
                                    // contractor listing
                                    // ignore: unnecessary_null_comparison
                                    if (controller.contactListingModel.data != null)
                                      if (controller.contactListingModel.data!.contractor!= null)
                                        ListView.builder(
                                            shrinkWrap: true,
                                            controller: controller.scrollController,
                                            itemCount: controller.contactListingModel.data!.contractor!.length,
                                            itemBuilder: (context,i){
                                              return InkWell(
                                                onTap: (){
                                                  connected == false
                                                      ? Container(): AppRouteMaps.goToContactInfoPage
                                                    (
                                                      controller.contactListingModel,
                                                      controller.contactListingModel.data!.contractor![i].id.toString(),
                                                      AppStrings.selectProjectContractor
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          (controller.contactListingModel.data!.contractor![i].image!=null && controller.contactListingModel.data!.contractor![i].image!="")? ClipRRect(
                                                            borderRadius:  BorderRadius.all(
                                                                Radius.circular(AppDimensions.fifty)),
                                                            child: Container(
                                                              height: AppDimensions.fifty,
                                                              width: AppDimensions.fifty,
                                                              color: AppColors.lightGreyColor.withOpacity(0.2),
                                                              child: CachedNetworkImage(
                                                                imageUrl: controller.contactListingModel.data!.contractor![i].image.toString(),
                                                                progressIndicatorBuilder:
                                                                    (context, url, downloadProgress) => Center(
                                                                    child: SizedBox(
                                                                      height: 20,width: 20,
                                                                      child: CircularProgressIndicator(
                                                                          value: downloadProgress.progress,
                                                                          strokeWidth: 2,
                                                                          color: AppColors.blueColor),
                                                                    )),
                                                              ),
                                                            ),
                                                          ):
                                                          CircleAvatar(
                                                            radius: AppDimensions.twentyFive,
                                                            backgroundColor: AppColors.grey6Color,
                                                            backgroundImage: const AssetImage(AssetsBase.carbonUserAvatarIcon),
                                                          ),
                                                          SizedBox(width: AppDimensions.twenty),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(controller.contactListingModel.data!.contractor![i].lastName.toString(),style: AppThemeStyles.black14),
                                                                  SizedBox(width:AppDimensions.five),
                                                                  Text(controller.contactListingModel.data!.contractor![i].firstName.toString(),style: AppThemeStyles.black14),
                                                                ],
                                                              ),
                                                              Text(TenantsLocalizations.of(context)!.find("selectProjectContractor"),style: AppThemeStyles.blackBold14),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor,)
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                              );

                                            }),
                                    // const Divider(),
                                    // lawyer listing
                                    // ignore: unnecessary_null_comparison
                                    if (controller.contactListingModel.data != null)
                                      if (controller.contactListingModel.data!.lawyer!= null)
                                        ListView.builder(
                                            shrinkWrap: true,
                                            controller: controller.scrollController,

                                            itemCount: controller.contactListingModel.data!.lawyer!.length,
                                            itemBuilder: (context,i){
                                              return InkWell(
                                                onTap: (){
                                                  connected == false
                                                      ? Container():AppRouteMaps.goToContactInfoPage
                                                    (
                                                      controller.contactListingModel,
                                                      controller.contactListingModel.data!.lawyer![i].id.toString(),
                                                      AppStrings.projectLawyer
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          (controller.contactListingModel.data!.lawyer![i].profileImage!=null && controller.contactListingModel.data!.lawyer![i].profileImage!="")? ClipRRect(
                                                            borderRadius:  BorderRadius.all(
                                                                Radius.circular(AppDimensions.fifty)),
                                                            child: Container(
                                                              height: AppDimensions.fifty,
                                                              width: AppDimensions.fifty,
                                                              color: AppColors.lightGreyColor.withOpacity(0.2),
                                                              child: CachedNetworkImage(
                                                                imageUrl: controller.contactListingModel.data!.lawyer![i].profileImage.toString(),
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
                                                          SizedBox(width: AppDimensions.twenty),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(controller.contactListingModel.data!.lawyer![i].lastName.toString(),style: AppThemeStyles.black14),
                                                                  SizedBox(width: AppDimensions.five),
                                                                  Text(controller.contactListingModel.data!.lawyer![i].firstName.toString(),style: AppThemeStyles.black14),
                                                                ],
                                                              ),
                                                              Text(TenantsLocalizations.of(context)!.find("projectLawyer"),style: AppThemeStyles.blackBold14),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor,)
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                              );

                                            }),
                                  ],
                                ),
                              ),
                            ),

                    ],
                  ),
                ),
                controller.isLoading ?
                Center(child:
                    SizedBox(
                    height: AppDimensions.twentyFive,
                    width: AppDimensions.twentyFive,
                    child: const CircularProgressIndicator(color: AppColors.skyLightColor))
                ):Container(),
              ],
            ),
          ));

    });


  }
}
