import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import '../../../appstyle/app_colors.dart';
import '../../../appstyle/app_dimensions.dart';
import '../../../appstyle/app_theme_styles.dart';
import '../../../appstyle/assets_images.dart';
import '../../../navigation/app_route_maps.dart';
import '../../../tenants_localizations.dart';
import '../../../utils/app_strings.dart';
import '../../../widgets/action_button_continue.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/cupertino_viewer.dart';
import '../controllers/login_page_controller.dart';

// ignore: must_be_immutable
class LoginPageView extends StatelessWidget{
  late  bool connected=false;
  bool checkBox = false;
  LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(builder: (controller) {
      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.login),context),
            body:Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                   connected = connectivity != ConnectivityResult.none;
                  return connectionMessage(child,connected,context);
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: AppDimensions.padding20,
                      child: Form(
                        key: controller.formKey,
                        child:  Stack(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer?Image.asset(AssetsBase.layerLoginIcon,height: AppDimensions.hundred,width: AppDimensions.hundred):Image.asset(AssetsBase.tanentLoginIcon,height: AppDimensions.hundred,width: AppDimensions.hundred),
                                        SizedBox(width: AppDimensions.ten),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(TenantsLocalizations.of(context)!.find(AppStrings.LoginToTheApp),style: AppThemeStyles.black18),
                                              SizedBox(height: AppDimensions.twenty),
                                              Text( controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer? TenantsLocalizations.of(context)!.find(AppStrings.LoginAsATenant):TenantsLocalizations.of(context)!.find(AppStrings.lawyerLogin),style: AppThemeStyles.blackBold18)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.twenty),
                                    TextFormField(
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColors.grey6Color),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color:AppColors.grey6Color),
                                          ),
                                          label: Text(TenantsLocalizations.of(context)!.find(AppStrings.enterTheEmailAddress)),
                                          labelStyle: AppThemeStyles.blue14
                                      ),

                                    ),
                                    SizedBox(height: AppDimensions.forty),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: AppDimensions.thirty,
                                          width: AppDimensions.thirty,
                                          child: Checkbox(
                                            value: checkBox,
                                            onChanged: (value) {
                                              checkBox = value!;
                                              controller.update();

                                            },
                                          ),
                                        ),
                                        SizedBox(width: AppDimensions.ten),
                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              connected==false?Container():AppRouteMaps.goToPrivacyPolicyPage();
                                            },
                                            child: RichText(
                                                text:  TextSpan(
                                                    text: TenantsLocalizations.of(context)!.find(AppStrings.iAmAgreeToThe),
                                                    style: AppThemeStyles.black14,
                                                    children:  [
                                                      TextSpan(
                                                          text: TenantsLocalizations.of(context)!.find(AppStrings.termsOfUseAndPrivacyPolicy),
                                                          style: AppThemeStyles.blueUnderline14
                                                      ),
                                                      TextSpan(
                                                          text: TenantsLocalizations.of(context)!.find(AppStrings.ofTheApplication),
                                                          style: AppThemeStyles.black14
                                                      )
                                                    ]
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppDimensions.forty),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ActionButtonWidget(
                                      onTap: (){
                                        connected==false?Container():submit(controller);},
                                      text:  TenantsLocalizations.of(context)!.find(AppStrings.login),
                                    ),
                                    controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer?SizedBox(height: AppDimensions.forty):SizedBox(height: AppDimensions.zero),
                                    controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer? Center(child: Text(TenantsLocalizations.of(context)!.find('Or'),style: AppThemeStyles.black26)):Container(),
                                    controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer?SizedBox(height: AppDimensions.forty):SizedBox(height: AppDimensions.zero,),
                                    controller.argumentData[0][AppStrings.type]!=AppStrings.lawayer? ActionButtonWidget(
                                        onTap: (){
                                          connected==false?Container(): AppRouteMaps.goToRegistrationPage1();
                                        },
                                        text:  TenantsLocalizations.of(context)!.find(AppStrings.RegisterAsNewTenant)
                                    ):Container(),
                                  ],
                                )

                              ],
                            ) ,
                          ],
                        ),
                      ),
                    ),
                    controller.isLoading ?
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: AppDimensions.twentyFive,
                          width: AppDimensions.twentyFive,
                          child: const CircularProgressIndicator(color: AppColors.skyLightColor)),
                    )
                        :Container(),
                  ],
                )
              );
            },
          )


        ),
      );

    }
    );

  }
  // user login button
  void submit(controller) {
    if (controller.formKey.currentState!.validate()) {
      if (controller.emailController.text.isEmpty) {
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.email));
      }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.emailController.text)){
        showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.validEmail));
      } else if(checkBox==false){
        showCheckBoxErrorDialogs();
      } else{
        controller.sendOtpRegistration(controller.emailController.text);
      }
    }
  }
}
