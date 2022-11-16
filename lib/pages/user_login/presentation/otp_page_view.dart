import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tenants_shield_project/pages/user_login/controllers/otp_page_controller.dart';
import '../../../appstyle/app_colors.dart';
import '../../../appstyle/app_dimensions.dart';
import '../../../appstyle/app_theme_styles.dart';
import '../../../appstyle/assets_images.dart';
import '../../../tenants_localizations.dart';
import '../../../utils/app_strings.dart';
import '../../../widgets/action_button_continue.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/cupertino_viewer.dart';

// ignore: must_be_immutable
class OtpPageView extends StatelessWidget {
   OtpPageView({Key? key}) : super(key: key);
  bool hasError = false;
   late  bool connected=false;
   @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpPageController>(builder: (controller) {
      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.verificationCode),context),
            body:Builder(
              builder: (BuildContext context) {
                return OfflineBuilder(
                  connectivityBuilder: (BuildContext context,
                      ConnectivityResult connectivity, Widget child) {
                    controller.connected = connectivity != ConnectivityResult.none;
                    return connectionMessage(child,controller.connected,context);
                  },
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: AppDimensions.padding20,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(AssetsBase.otpLoginIcon,height: AppDimensions.hundred,width: AppDimensions.hundred),
                                        SizedBox(width: AppDimensions.ten),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(TenantsLocalizations.of(context)!.find(AppStrings.verificationCode),style: AppThemeStyles.black20),
                                              SizedBox(height: AppDimensions.twenty),
                                              Text(TenantsLocalizations.of(context)!.find(AppStrings.weSentYouTheCodeToYourEmail),style: AppThemeStyles.blackBold20),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.twenty),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.theCodeWasSentTo),style: AppThemeStyles.black20),
                                        Row(
                                          children: [
                                            Text("*******",style: AppThemeStyles.black20),
                                            Text(controller.emailForOtp.toString().substring(0, 3),style: AppThemeStyles.black20),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppDimensions.forty),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: PinCodeTextField(
                                        length: 5,
                                        controller: controller.pinController,
                                        appContext: context,
                                        // autoFocus: true,
                                        obscureText: false,
                                        animationType: AnimationType.fade,
                                        pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius: BorderRadius.circular(AppDimensions.six),
                                            fieldHeight: AppDimensions.fifty,
                                            fieldWidth: AppDimensions.fifty,
                                            activeFillColor: Colors.transparent,
                                            inactiveFillColor: Colors.transparent,
                                            selectedFillColor: Colors.transparent,
                                            activeColor: AppColors.blueColor,
                                            disabledColor:AppColors.blueColor,
                                            selectedColor: hasError ? AppColors.redColor : AppColors.blueColor,
                                            errorBorderColor: AppColors.redColor,
                                            inactiveColor:
                                            hasError ? AppColors.redColor: AppColors.blueColor,
                                            borderWidth: 0.7
                                        ),
                                        animationDuration: const Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        inputFormatters: const [],
                                        keyboardType: TextInputType.number,
                                        onCompleted: (v) {},
                                        onChanged: (value) {
                                          // ignore: unrelated_type_equality_checks
                                          if(controller.pinController.text.length==5){
                                            controller.connected==false?Container(): submit(controller);
                                          }else{
                                            Container();
                                          }
                                        },
                                        beforeTextPaste: (text) => true,
                                      ),
                                    ),
                                    SizedBox(height: AppDimensions.twenty),
                                    Center(child: Text(TenantsLocalizations.of(context)!.find(AppStrings.didNotGetTheCode),style: AppThemeStyles.blackBold20)),
                                    SizedBox(height: AppDimensions.twenty),
                                    Center(child: InkWell(
                                      onTap: (){
                                        controller.sendOtpRegistration(controller.emailForOtp.toString());
                                      },
                                        child: Text(TenantsLocalizations.of(context)!.find(AppStrings.sendAgain),style: AppThemeStyles.blueBold20))),
                                    SizedBox(height: AppDimensions.twenty),
                                  ],
                                ),
                              ),
                              ActionButtonWidget(
                                onTap: (){
                                  controller.connected==false?Container(): submit(controller);
                                },
                                text:  TenantsLocalizations.of(context)!.find(AppStrings.login),
                              ),
                            ],
                          ),
                          controller.isLoading ?  Center(child: SizedBox(
                              height: AppDimensions.twentyFive,
                              width: AppDimensions.twentyFive,
                              child: const CircularProgressIndicator(color: AppColors.skyLightColor))):Container(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )

        ),
      );

    });

  }
   void submit(controller) {
     if (controller.formKey.currentState!.validate()) {
       if (controller.pinController.text.isEmpty) {
         showErrorDialogs(TenantsLocalizations.of(Get.context!)!.find(AppStrings.verificationCode));
       }  else{
         controller.connected==false?Container(): controller.isType==AppStrings.login?
         controller.loginApi(controller.pinController.text):
         controller.uploadProfileImage(controller.pinController.text);
       }
     }
   }
}
