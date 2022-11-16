import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/delete_message_controller.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/action_button_continue.dart';
import '../../../../widgets/app_bar.dart';
import '../../dashboard_bar/dashboard_bar_binding.dart';
import '../../dashboard_bar/dashboard_bar_view.dart';

// ignore: must_be_immutable
class DeleteMessagePageView extends StatelessWidget {
  late  bool connected=false;
   DeleteMessagePageView({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<DeletePageController>()
      ? Get.find<DeletePageController>()
      : Get.put(DeletePageController());

  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<DeletePageController>(builder: (controller) {
      return WillPopScope(
        onWillPop: ()async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("NotificationId", "");
          if (kDebugMode) {
            print("al;sfd'..${prefs.getString("NotificationId")}");
          }
          Get.back(result: "Yes");
          controller.update();
          return true;
        },

        child: Scaffold(
          appBar: AppBar(
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimensions.twenty),
                  bottomRight: Radius.circular(AppDimensions.twenty),
                )

            ), elevation: 0,
            centerTitle: false,
            leading: InkWell(
              onTap: ()async{
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("NotificationId", "");
                Get.back(result:  "Yes");
                controller.update();
              },
              child: Padding(
                padding: AppDimensions.margin18_0_0_18,
                child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
              ),
            ),
            actions: [

              InkWell(
                  onTap: (){
                    projectCodePopUPDialogs(controller,controller.data!.id.toString());
                  },
                  child:  Icon(CupertinoIcons.delete,color:AppColors.redColor,size: AppDimensions.twenty)),
              SizedBox(width:AppDimensions.twenty),
            ],
            backgroundColor: AppColors.skyHighLightColor,
            title: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Text(TenantsLocalizations.of(context)!.find(AppStrings.messages),style: AppThemeStyles.black16)),

          ),
          body: OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                connected = connectivity != ConnectivityResult.none;
                return connectionMessage(child,connected,context);

              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppDimensions.padding20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.data!.title.toString(),style: AppThemeStyles.blackBold16),
                      SizedBox(height: AppDimensions.twenty),
                      Text( DateFormat("HH:mm dd.MM.yyyy").format(DateTime.parse(controller.data!.createdAt)),style: AppThemeStyles.blue14),
                      SizedBox(height: AppDimensions.twenty),
                      controller.data!.description.toString()=="null"?Container():  HtmlWidget(
                        controller.data!.description.toString(),
                        textStyle: AppThemeStyles.black14,
                      ),
                      controller.data!.type.toString()=="New information file"? SizedBox(height: 50):Container(),
                      // controller.data!.type.toString()=="New information file"?Spacer():Container(),
                      controller.data!.type.toString()=="New information file"? ActionButtonWidget(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString("infoMessageId", controller.data!.messageId.toString());
                          Get.offAll(() => DashBoardBarView(
                            isSelected: 4,
                          ),
                              binding: DashBoardPageBinding(),
                              transition: Transition.fadeIn
                          );
                          // connected==false?Container(): submit(controller);
                        },
                        text:  TenantsLocalizations.of(context)!.find(AppStrings.viewFiles),
                      ):Container(),
                      // Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfoDes),style: AppThemeStyles.black14),
                    ],
                  ),
                ),
              )
          ),
        ),
      );

    });
  }
  void projectCodePopUPDialogs(controller,String messageId) {
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
                  TenantsLocalizations.of(Get.context!)!.find(AppStrings.deleteAMessage),
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
                        text: TenantsLocalizations.of(Get.context!)!.find(AppStrings.deleteMessageDescription),
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
                              Get.back(result: "Yes");
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
                            width: 1,
                            color: Colors.grey.shade400
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              controller.messageDeleteApi(messageId);
                              Get.back();

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

}
