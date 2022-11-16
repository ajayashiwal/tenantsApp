import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/message_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class MessagePageView extends StatelessWidget {
  late  bool connected=false;
   MessagePageView({Key? key}) : super(key: key);
  var dsh = Get.isRegistered<MessagePageController>()
      ? Get.find<MessagePageController>()
      : Get.put(MessagePageController());

  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<MessagePageController>(builder: (controller) {
      return WillPopScope(
        onWillPop: ()async{
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

                Get.back(result: "Yes");
                controller.update();
                },
              child: Padding(
                padding: AppDimensions.margin18_0_0_18,
                child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
              ),
            ),
            actions: [
              Padding(
                padding:  EdgeInsets.only(left: AppDimensions.ten),
                child: InkWell(
                  onTap: (){
                    AppRouteMaps.goToContactPage();
                  },
                  child: Row(
                    children: [
                      Image.asset(AssetsBase.mailIcon, height: AppDimensions.twentyFour,color: AppColors.blueColor),
                      SizedBox(width:AppDimensions.five),
                      Text("יצירת קשר",style: AppThemeStyles.blue16),
                    ],
                  ),
                ),
              )
            ],
            backgroundColor: AppColors.skyHighLightColor,
            title: InkWell(
                onTap: (){
                  Get.back(result: "Yes");
                  controller.update();
                },
                child: Text(TenantsLocalizations.of(context)!.find(AppStrings.messages),style: AppThemeStyles.black16)),

          ),
          body: OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                connected = connectivity != ConnectivityResult.none;
                return connectionMessage(child,connected,context);
              },
              child: controller.isLoading ?
              Center(child: SizedBox(
                  height: AppDimensions.twentyFive,
                  width: AppDimensions.twentyFive,
                  child: const CircularProgressIndicator(color: AppColors.skyLightColor))):Column(
                    children: [
                      // ignore: unnecessary_null_comparison
                      if (controller.messageListModel != null)
                        if (controller.messageListModel.data != null)
                          Expanded(
                            child: RefreshIndicator(
                              color: AppColors.blueColor,
                              onRefresh: () async {
                                await Future.delayed(const Duration(seconds: 2));
                                controller.messageListApiWithoutLoading();
                              },
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.messageListModel.data!.length,
                            controller: controller.scrollController,
                            separatorBuilder: (context, i) {
                              return const Divider(height:1);
                            },
                            itemBuilder: (context,i){
                              return  Slidable(
                                key: const ValueKey(1),
                                startActionPane:  ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.2,
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        doNothing(context,controller,controller.messageListModel.data![i].id.toString());
                                      },
                                      borderRadius: BorderRadius.zero,
                                      backgroundColor:AppColors.redColor,
                                      foregroundColor: AppColors.whiteColor,
                                      icon: CupertinoIcons.delete,
                                    ),
                                  ],
                                ),
                                endActionPane:  ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.2,
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        doNothing(context,controller,controller.messageListModel.data![i].id.toString());
                                      },
                                      spacing: 10,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: AppColors.redColor,
                                      foregroundColor: AppColors.whiteColor,
                                      icon: CupertinoIcons.delete,
                                    ),

                                  ],
                                ),
                                child: InkWell(
                                  onTap: ()async{
                                    controller.readMessageApi(controller.messageListModel.data![i].id.toString());
                                    var result = await AppRouteMaps.goToDeleteMessagePage(
                                        controller.messageListModel,
                                        controller.messageListModel.data![i].id.toString()
                                    );
                                    if(result!=null )
                                    {
                                      if(result=="Yes"){
                                        controller.messageListApi();
                                        controller.update();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: AppDimensions.padding20,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(AssetsBase.messagerIcon,height: AppDimensions.twenty,width: AppDimensions.twenty),
                                                  SizedBox(width: AppDimensions.ten),
                                                  Text( DateFormat("HH:mm dd.MM.yyyy").format(DateTime.parse(controller.messageListModel.data![i].createdAt)),style: AppThemeStyles.blue14),
                                                ],
                                              ),
                                              SizedBox(height: AppDimensions.ten),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  controller.messageListModel.data![i].isRead==0? const CircleAvatar(
                                                    backgroundColor: AppColors.lightGreenColor,
                                                    radius: 8,
                                                  ):const CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    radius: 8,
                                                  ),
                                                  SizedBox(width:AppDimensions.ten),
                                                  Expanded(child: Text(controller.messageListModel.data![i].title.toString(),style: AppThemeStyles.black14)),
                                                ],
                                              ),
                                              SizedBox(height: AppDimensions.five),
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    radius: 8,
                                                  ),
                                                  SizedBox(width:AppDimensions.ten),

                                                  Expanded(child: Text(controller.messageListModel.data![i].summary.toString(),style: AppThemeStyles.black14)),
                                                ],
                                              ),


                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },

                        ),
                      ),
                          ),
                    ],
                  )
          ),

        ),
      );

    });
  }


}

void doNothing(BuildContext context, controller,messageId) {
  projectCodePopUPDialogs(controller,messageId);
}

void projectCodePopUPDialogs(controller,messageId) {
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
                            Get.back();
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

