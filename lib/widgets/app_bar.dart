import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_view.dart';
import 'package:tenants_shield_project/tenants_localizations.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../appstyle/app_colors.dart';

appBar(String title,context){
  return AppBar(
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppDimensions.twenty),
            bottomRight: Radius.circular(AppDimensions.twenty),
          )
      ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.skyHighLightColor,
      title: InkWell(
          onTap: (){
            Get.back();
          },
          child: Text(title,style: AppThemeStyles.black16)),
      titleSpacing: 0,
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: Padding(
          padding:AppDimensions.margin18_0_0_18,
          child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
        ),
      )
  );
}

appBar1(String title,context){
  return AppBar(

      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.skyHighLightColor,
      title: InkWell(
          onTap: (){
            Get.back();
          },
          child: Text(title,style: AppThemeStyles.black16)),
      titleSpacing: 0,
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: Padding(
          padding:AppDimensions.margin18_0_0_18,
          child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
        ),
      )
  );
}

connectionMessage(child,connected,context){
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
          connected ?Colors.transparent : AppColors.blackColor,
          child: connected
              ? Container()
              : Padding(
            padding: AppDimensions.margin10_10_20_20,
            child: Text(
                TenantsLocalizations.of(context)!.find(AppStrings.connectionCheckMessage),
                style: AppThemeStyles.white16
            ),
          ),
        ),
      ),
    ],
  );
}

backIcon(context){
  return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.skyHighLightColor,
      titleSpacing: 0,
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: Padding(
          padding: AppDimensions.margin18_0_0_18,
          child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
        ),
      )
  );
}

title(String title,context){
  return AppBar(
    shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.twenty),
          bottomRight: Radius.circular(AppDimensions.twenty),
        )

    ), elevation: 0,
    centerTitle: false,
    backgroundColor: AppColors.skyHighLightColor,
    title: InkWell(
      onTap: (){
          Get.offAll(() => DashBoardBarView(
            isSelected: 2,
          ),
              binding: DashBoardPageBinding(),
            transition: Transition.fadeIn,
          );
      },
        child: Text(title,style: AppThemeStyles.black16),
    ),
      titleSpacing: 0,

      leading: InkWell(
        onTap: (){
          Get.offAll(() => DashBoardBarView(
            isSelected: 2,
          ),
            binding: DashBoardPageBinding(),
            transition: Transition.fadeIn,

          );
          },
        child: Padding(
          padding:AppDimensions.margin18_0_0_18,
          child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
        ),
      )


  );
}

