
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../appstyle/app_colors.dart';
import '../../../appstyle/assets_images.dart';
import '../../../tenants_localizations.dart';

// ignore: must_be_immutable
class DashBoardBarView extends StatelessWidget {
  int?  isSelected;
  DashBoardBarView({Key? key,this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardPageController>(builder: (controller) {
      if(isSelected!=null){
        controller.tab=isSelected!;
      }
      controller.getProfile();
      return Container(
        // color: AppColors.blackColor,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            bottomNavigationBar:
            Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.ten)),
                    color: AppColors.blueColor
                ),
                height: AppDimensions.seventy,
                child: Padding(
                  padding: AppDimensions.padding5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      {
                        AppStrings.icon:controller.imagesUrl.toString(),
                        AppStrings.text:TenantsLocalizations.of(context)!.find(AppStrings.profileTab),
                        AppStrings.pos: 0,
                      },
                      {
                        AppStrings.icon:AssetsBase.usersTabIcon,
                        AppStrings.text:TenantsLocalizations.of(context)!.find(AppStrings.tenantsTab),
                        AppStrings.pos: 1,
                      },
                      {
                        AppStrings.icon:AssetsBase.homeTabIcon,
                        AppStrings.text:TenantsLocalizations.of(context)!.find(AppStrings.homePageTab),
                        AppStrings.pos: 2,
                      },
                      {
                        AppStrings.icon:AssetsBase.menuTabIcon,
                        AppStrings.text:TenantsLocalizations.of(context)!.find(AppStrings.contactsTab),
                        AppStrings.pos: 3,
                      },
                      {
                        AppStrings.icon:AssetsBase.documentTabIcon,
                        AppStrings.text:TenantsLocalizations.of(context)!.find(AppStrings.informationTab),
                        AppStrings.pos: 4,
                      },
                    ].map((e) => InkWell(
                      onTap: (){
                        isSelected = e[AppStrings.pos] as int;
                          },
                      child: LayoutBuilder(
                          builder: (context, snapshot) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimensions.eight),
                                color: (controller.tab)==e[AppStrings.pos]?AppColors.whiteColor:AppColors.blueColor
                            ),
                            child: Padding(
                              padding: AppDimensions.margin10_10_5_5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  e[AppStrings.pos]==0? e[AppStrings.icon].toString()!="null" && e[AppStrings.icon].toString()!=""? ClipRRect(
                                    borderRadius:  BorderRadius.all(
                                        Radius.circular(AppDimensions.fifty)),
                                    child: Container(
                                      height: AppDimensions.twentyFive,
                                      width: AppDimensions.twentyFive,
                                      color: AppColors.lightGreyColor.withOpacity(0.2),
                                      child: CachedNetworkImage(
                                        imageUrl: e[AppStrings.icon].toString(),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) => Center(
                                            child: SizedBox(
                                              height: AppDimensions.ten,
                                              width: AppDimensions.ten,
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress.progress,
                                                  color: AppColors.whiteColor),
                                            )),
                                      ),
                                    ),
                                  ): CircleAvatar(
                                      radius: AppDimensions.forTeen,
                                      backgroundColor: AppColors.whiteColor,
                                      backgroundImage:  const AssetImage(AssetsBase.carbonUserAvatarIcon)):
                                      Image.asset(e[AppStrings.icon].toString(), color: ( controller.tab)==e[AppStrings.pos]?AppColors.blueColor:AppColors.whiteColor,height: AppDimensions.twenty,width: AppDimensions.twenty),
                                      Text(e[AppStrings.text].toString(), style: TextStyle(color: (controller.tab)==e[AppStrings.pos]?AppColors.blueColor:AppColors.whiteColor),)
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    )).toList(),
                  ),
                ),
              ),

            body: controller.type=="tenant"?(controller.tabs1[controller.tab]):(controller.tabs2[controller.tab]),
          ),
        ),
      );
    });

  }
}

