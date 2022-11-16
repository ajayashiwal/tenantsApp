import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/controllers/Update_officedetail_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/action_button_continue.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class UpdateOfficeDetail extends StatelessWidget{
  late  bool connected=false;
  UpdateOfficeDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<UpdateOfficeDetailController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.updateOfficeDetails),context),
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
                    Padding(
                      padding: AppDimensions.margin0_20_20_0,
                      child: Column(
                        children: [
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.officeNameController,
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.officeName),
                                            style: AppThemeStyles.blue14
                                        )
                                      ]
                                  )),

                            ),
                          ),
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.subtitleController,
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.subtitle),
                                            style: AppThemeStyles.blue14
                                        )
                                      ]
                                  )),

                            ),
                          ),
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.officePhoneController,
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.officePhone),
                                            style: AppThemeStyles.blue14
                                        )
                                      ]
                                  )),

                            ),
                          ),
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.officeEmailController,
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.OfficeEmail),
                                            style: AppThemeStyles.blue14
                                        )
                                      ]
                                  )),

                            ),
                          ),
                          SizedBox(height: AppDimensions.ten),
                          TextFormField(
                            controller: controller.officeAddressController,
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
                                            text: TenantsLocalizations.of(context)!.find(AppStrings.OfficeAddress),
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
                                  ? Container():controller.updateOfficeProfileApi(
                               controller.officeNameController.text,
                               controller.subtitleController.text,
                               controller.officePhoneController.text,
                               controller.officeEmailController.text,
                               controller.officeAddressController.text,
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
               Center(
                   child: SizedBox(
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
