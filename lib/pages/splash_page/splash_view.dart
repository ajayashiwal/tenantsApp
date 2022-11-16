
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/appstyle/assets_images.dart';
import 'package:tenants_shield_project/pages/splash_page/splash_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../tenants_localizations.dart';

// ignore: must_be_immutable
class SplashView extends StatelessWidget {
    const SplashView({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(AssetsBase.splashImage),
                      Positioned(
                          top: AppDimensions.fifty,
                          left: 0,right: 0,
                          child: Image.asset(AssetsBase.appIcon1,height: MediaQuery.of(context).size.height/4,width:  MediaQuery.of(context).size.height/4)),
                      Positioned(
                        top: MediaQuery.of(context).size.height/1.5,
                        left: 0,right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(TenantsLocalizations.of(context)?.find(AppStrings.yourDecisions)??"", style: AppThemeStyles.black24),
                            Text(TenantsLocalizations.of(context)?.find(AppStrings.ourDefense)??"", style: AppThemeStyles.black30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
          );
        }
        );
  }

}
