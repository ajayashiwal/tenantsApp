import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/appstyle/assets_images.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_home_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appStyle/app_fonts.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import 'dart:math' as math;
import '../../../../widgets/app_bar.dart';


// ignore: must_be_immutable
class LawyerHomePageView extends StatelessWidget {
   LawyerHomePageView({Key? key}) : super(key: key);
   var dsh = Get.isRegistered<LawyerHomePageController>()
      ? Get.find<LawyerHomePageController>()
      : Get.put(LawyerHomePageController());
   @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<LawyerHomePageController>(builder: (controller) {
      return  Scaffold(
          backgroundColor: Colors.white,
          body: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                  controller.connected = connectivity != ConnectivityResult.none;
                  return connectionMessage(child,controller.connected,context);
                },
                child: controller.message=="No Project Assign"?Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("No Project Assign",style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ):controller.isLoading?
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: SizedBox(
                        height: AppDimensions.twentyFive,
                        width: AppDimensions.twentyFive,
                        child: const CircularProgressIndicator(color: AppColors.skyLightColor)),
                  ),
                ):Stack(
                  children: [
                    Stack(
                      children: [
                        Image.asset(AssetsBase.homeBackgroundIcon,fit: BoxFit.cover),
                        Container(
                          width: double.infinity,
                          color: Colors.white70,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:AppDimensions.forty),
                      child: Column(
                        children: [
                          Padding(
                            padding: AppDimensions.margin0_20_20_0,
                            child: Container(
                              width: double.infinity,
                              height: AppDimensions.forty,
                              decoration: BoxDecoration(
                                  color: Colors.white38,
                                  border: Border.all(
                                      color: AppColors.lightGreyColor
                                  ),
                                  borderRadius: BorderRadius.circular(AppDimensions.five)
                              ),
                              child:controller.projectsList.isEmpty?Container():
                              Padding(
                                padding: AppDimensions.margin0_10_10_0,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      width: 200,
                                      height: 0.8,
                                      color: const Color.fromRGBO(185, 191, 214, 1),
                                    ),
                                    style:  TextStyle(fontSize:AppDimensions.sixTeen, color: AppColors.blackColor),
                                    icon:  Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down_outlined,color: AppColors.lightGreyColor,size: AppDimensions.thirty)),
                                    value: controller.projectName,
                                    iconEnabledColor: const Color.fromRGBO(76, 73, 73, 0.6),
                                    items:(controller.projectsList).map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                          style:  TextStyle(fontSize: AppDimensions.sixTeen, color: AppColors.blackColor),
                                        )
                                    ),
                                    ).toList(),
                                      onChanged: (value) async{
                                           controller.projectName = value.toString();
                                            for (int i = 0; i < controller.projectsList.length; i++) {
                                              if (value == controller.projectsList[i]) {
                                                controller.getProjectList(controller.projectsIdList[i].toString());
                                                final prefs = await SharedPreferences.getInstance();
                                                await prefs.setString(AppStrings.projectId, controller.projectsIdList[i].toString());
                                                controller.update();
                                              }
                                            }
                                            },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.forty),
                          Text(TenantsLocalizations.of(context)!.find(AppStrings.projectProgressStatus),style: TextStyle(
                            fontFamily: AppFonts.appRubikBoldFontFamily,
                            fontSize: AppDimensions.seventeen,
                            color: AppColors.blackColor,
                          )),
                          // Text(TenantsLocalizations.of(context)!.find(AppStrings.projectProgressStatus),style: AppThemeStyles.blackBold14),
                          SizedBox(height: AppDimensions.ten),
                          SizedBox(
                            height: AppDimensions.hundred,
                            // color:Colors.green,
                            child: Stack(
                              fit: StackFit.expand,
                              children:  [
                                if (controller.projectListModel.data!.stages!.isNotEmpty )
                                  Padding(
                                  padding: AppDimensions.marginTopTwenty,
                                  child:const Align(
                                    alignment:Alignment.topCenter,
                                    child: Divider(
                                      color: AppColors.blueColor,
                                      thickness: 2,
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                if (controller.projectListModel != null)
                                  if (controller.projectListModel.data!.stages!.isNotEmpty)
                                    PageView(
                                        controller: PageController(viewportFraction: 0.25,initialPage: controller.visibleIndex??0),
                                        children: List.generate(controller.projectListModel.data!.stages!.length, (i){
                                          String url=controller.projectListModel.data!.stages![i].stage!.image.toString();
                                          String fileName = url.split('.').last;
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  controller.projectListModel.data!.stages![i].status.toString()=="Started"? Container(
                                                      height:AppDimensions.fiftyFive,
                                                      width:AppDimensions.fiftyFive,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.whiteColor,
                                                          borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                          border: Border.all(color: AppColors.skyColor,width: AppDimensions.two)
                                                      ),
                                                      child: Padding(
                                                        padding: AppDimensions.padding10,
                                                        child:
                                                        // ignore: unnecessary_null_comparison
                                                        controller.projectListModel.data!.stages![i].stage!.image.toString()==null?
                                                        Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                        fileName=="svg"?   SvgPicture.network(
                                                          controller.projectListModel.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          color: AppColors.blueColor,
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ):
                                                        CachedNetworkImage(
                                                          imageUrl: controller.projectListModel.data!.stages![i].stage!.image.toString(),
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
                                                      )): (controller.projectListModel.data!.stages![i].status=="Finished"?
                                                  Container(
                                                      height:AppDimensions.fifty,
                                                      width:AppDimensions.fifty,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.whiteColor,
                                                          borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                          border: Border.all(color: AppColors.lightGreenColor)
                                                      ),
                                                      child: Padding(
                                                        padding: AppDimensions.padding10,
                                                        // ignore: unnecessary_null_comparison
                                                        child: controller.projectListModel.data!.stages![i].stage!.image.toString()==null?
                                                        Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                        fileName=="svg"? SvgPicture.network(
                                                          controller.projectListModel.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          color: AppColors.lightGreenColor,
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ):
                                                        CachedNetworkImage(
                                                          imageUrl: controller.projectListModel.data!.stages![i].stage!.image.toString(),
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
                                                      )):
                                                  Container(
                                                      height:AppDimensions.fifty,
                                                      width:AppDimensions.fifty,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.whiteColor,
                                                          borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                          border: Border.all(color: Colors.grey)
                                                      ),
                                                      child: Padding(
                                                        padding: AppDimensions.padding10,
                                                        // ignore: unnecessary_null_comparison
                                                        child: controller.projectListModel.data!.stages![i].stage!.image.toString()==null?
                                                        Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                        fileName=="svg"?  SvgPicture.network(
                                                          controller.projectListModel.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ):
                                                        CachedNetworkImage(
                                                          imageUrl: controller.projectListModel.data!.stages![i].stage!.image.toString(),
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
                                                      ))),
                                                  controller.projectListModel.data!.stages![i].status=="Started"?Positioned(
                                                    right: 0,top: 0,
                                                    child: CircleAvatar(
                                                      radius: AppDimensions.ten,
                                                      backgroundColor: AppColors.blueColor,
                                                      child: Center(child: Icon(CupertinoIcons.hourglass_tophalf_fill,color: AppColors.whiteColor,size: AppDimensions.fifTeen)),
                                                    ),
                                                  ):(controller.projectListModel.data!.stages![i].status=="Finished"?Positioned(
                                                    right: 0,top: 0,
                                                    child: CircleAvatar(
                                                      radius: AppDimensions.ten,
                                                      backgroundColor: AppColors.lightGreenColor,
                                                      child: Center(child: Icon(CupertinoIcons.check_mark,color: AppColors.whiteColor,size: AppDimensions.fifTeen)),
                                                    ),
                                                  ):Positioned(
                                                    right: 0,top: 0,
                                                    child: CircleAvatar(
                                                      radius: AppDimensions.ten,
                                                      backgroundColor: Colors.transparent,
                                                    ),
                                                  )
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: AppDimensions.ten),
                                              SizedBox(
                                                  width:AppDimensions.hundred,
                                                  // color:Colors.red,
                                                  child: Text(controller.projectListModel.data!.stages![i].stage!.name.toString(),style:controller.projectListModel.data!.stages![i].status.toString()=="Started"? AppThemeStyles.blackBold12:AppThemeStyles.black12,textAlign: TextAlign.center))

                                            ],
                                          );
                                        })
                                    ),

                              ],
                            ),
                          ),
                          // SizedBox(height: AppDimensions.ten),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  AppRouteMaps.goToLawyerAllProjectStage(controller.projectListModel);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppDimensions.ten),
                                      color: AppColors.blueColor
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,right: 10,top: 5,bottom: 5
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.viewAllProjectStages),style: TextStyle(
                                          fontFamily: AppFonts.appRubikMediumFontFamily,
                                          fontSize: AppDimensions.sixTeen,
                                          color: AppColors.whiteColor,
                                        ),textAlign: TextAlign.center),
                                        SizedBox(width: AppDimensions.ten),
                                        Icon(Icons.arrow_forward_ios_outlined,color: AppColors.whiteColor,size: AppDimensions.fifTeen)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     InkWell(
                          //       onTap: (){
                          //         AppRouteMaps.goToLawyerAllProjectStage(controller.projectListModel);
                          //       },
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(AppDimensions.ten),
                          //             color: AppColors.blueColor
                          //         ),
                          //         child: Padding(
                          //           padding: AppDimensions.padding10,
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               Text(TenantsLocalizations.of(context)!.find(AppStrings.viewAllProjectStages),style: AppThemeStyles.whiteBold16,textAlign: TextAlign.center),
                          //               SizedBox(width: AppDimensions.ten),
                          //               Icon(Icons.arrow_forward_ios_outlined,color: AppColors.whiteColor,size: AppDimensions.twenty)
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: AppDimensions.ten),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius:  BorderRadius.only(
                                    topRight: Radius.circular(AppDimensions.twenty),
                                    topLeft: Radius.circular(AppDimensions.twenty),
                                  ),
                                  boxShadow:  [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3), //color of shadow
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                              ),
                              child: RefreshIndicator(
                                color: AppColors.blueColor,
                                onRefresh: () async {
                                  await Future.delayed(const Duration(seconds: 2));
                                  controller.getWithoutLoadingProjectList("");
                                },
                                child: ListView(
                                  padding: AppDimensions.padding15,
                                  shrinkWrap: true,
                                  children: [
                                    if(controller.projectListModel.data!.taskInProgress!.isNotEmpty)
                                      Text(TenantsLocalizations.of(context)!.find(AppStrings.tasksInProgress),style: TextStyle(
                                        fontFamily: AppFonts.appRubikBoldFontFamily,
                                        fontSize: AppDimensions.twenty,
                                        color: AppColors.blackColor,
                                      )),
                                    // Text(TenantsLocalizations.of(context)!.find(AppStrings.tasksInProgress),style: AppThemeStyles.blackBold18),
                                    if(controller.projectListModel.data!.taskInProgress!.isNotEmpty)
                                    // ignore: unnecessary_null_comparison
                                    if(controller.projectListModel!=null)
                                      if(controller.projectListModel.data!=null)
                                    ListView.builder(
                                            itemCount: controller.projectListModel.data!.taskInProgress!.length,
                                            shrinkWrap: true,
                                            controller: controller.scrollController,
                                            itemBuilder: (context,index){
                                              DateTime startingDate=DateTime.parse(controller.projectListModel.data!.taskInProgress![index].startDate);
                                              DateTime endDate=DateTime.parse(controller.projectListModel.data!.taskInProgress![index].endDate);
                                              DateTime currentDate=DateTime.now();
                                              int dateDifference=endDate.difference(startingDate).inDays;
                                              Duration dateDiff=currentDate.difference(startingDate);
                                              String parsentage22= (double.parse(((dateDiff.inDays/dateDifference)*100).round().toStringAsFixed(0))).toStringAsFixed(0);
                                              double parsentage33=double.parse(parsentage22)/100;
                                              int listSize = 0;
                                              int restValue = 0;
                                              if (controller.projectListModel.data!.taskInProgress![index].completeUsers!.length > 4) {
                                                listSize = 4;
                                                restValue = controller.projectListModel.data!.taskInProgress![index].completeUsers!.length - listSize;
                                              } else {
                                                listSize = controller.projectListModel.data!.taskInProgress![index].completeUsers!.length;
                                              }

                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20
                                                ),
                                                child:InkWell(
                                                  onTap: (){
                                                    controller.projectListModel.data!.taskInProgress![index].taskType.toString()=="regular"?
                                                    AppRouteMaps.goToLawyerGeneralTaskPage(
                                                      controller.projectListModel.data!.taskInProgress![index].id.toString(),

                                                    ):AppRouteMaps.goToCloseTaskPage(
                                                        controller.projectListModel.data!.taskInProgress![index].id.toString(),
                                                        "taskInProgress",
                                                         "laawyer"
                                                    );
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                          color: AppColors.lightColor.withOpacity(0.7)
                                                      ),
                                                      child: Padding(
                                                          padding: AppDimensions.padding10,
                                                          child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(child: Text(controller.projectListModel.data!.taskInProgress![index].task!.name!.toString(),style: TextStyle(
                                                                      fontFamily: AppFonts.appRubikMediumFontFamily,
                                                                      fontSize: AppDimensions.eighteen,
                                                                      color: AppColors.blackColor,
                                                                    ))),


                                                                  ],
                                                                ),
                                                                SizedBox(height: AppDimensions.ten),
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.calendar_today_outlined,color: AppColors.blueColor,size:AppDimensions.twenty),
                                                                    SizedBox(width: AppDimensions.five),
                                                                    Text("${TenantsLocalizations.of(context)!.find(AppStrings.unit)} ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectListModel.data!.taskInProgress![index].endDate.toString()))}",style: AppThemeStyles.black14),
                                                                  ],
                                                                ),
                                                                SizedBox(height: AppDimensions.ten),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Expanded(
                                                                      child: SizedBox(
                                                                        height:50,width: 200,
                                                                        child: Stack(
                                                                          alignment:Alignment.centerRight,
                                                                          children: [
                                                                            for (int i = 0; i < listSize; i++)
                                                                              i == 0?
                                                                              controller.projectListModel.data!.taskInProgress![index].completeUsers![i].tenant!.profileImage.toString()=="null"?
                                                                              Container(
                                                                                width: AppDimensions.forty,
                                                                                height: AppDimensions.forty,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    border: Border.all(
                                                                                        width: 0.5, color: AppColors.whiteColor),
                                                                                    image: const DecorationImage(
                                                                                        image: AssetImage("assets/images/app-icon2.png")
                                                                                    )
                                                                                ),
                                                                              ):
                                                                              Container(
                                                                                width: AppDimensions.forty,
                                                                                height: AppDimensions.forty,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    border: Border.all(
                                                                                        width: 0.5, color: AppColors.whiteColor),
                                                                                    image: DecorationImage(
                                                                                        image: NetworkImage(controller.projectListModel.data!.taskInProgress![index].completeUsers![i].tenant!.profileImage.toString())
                                                                                    )
                                                                                ),
                                                                              )
                                                                                  : Padding(
                                                                                padding:EdgeInsets.only(right: i * (75) / 3.4),
                                                                                child:
                                                                                Container(
                                                                                  width: AppDimensions.forty,
                                                                                  height: AppDimensions.forty,
                                                                                  decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                      border: Border.all(
                                                                                          width: 1,
                                                                                          color: AppColors.whiteColor),
                                                                                      image: DecorationImage(
                                                                                          image: NetworkImage(controller.projectListModel.data!.taskInProgress![index].completeUsers![i].tenant!.profileImage.toString())
                                                                                      )
                                                                                  ),
                                                                                  // child: Image.asset( homeModel1[i].image),
                                                                                ),
                                                                              ),
                                                                            if (restValue > 0)
                                                                              Padding(
                                                                                padding: EdgeInsets.only(right: listSize * (75) /3.5),
                                                                                child: Container(
                                                                                  height: AppDimensions.forty,
                                                                                  width: AppDimensions.forty,
                                                                                  decoration: BoxDecoration(
                                                                                      border:
                                                                                      Border.all(width: 1, color: AppColors.whiteColor),
                                                                                      borderRadius: BorderRadius.circular(AppDimensions.forty),
                                                                                      color: AppColors.blueColor),
                                                                                  padding: AppDimensions.padding5,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "$restValue+",
                                                                                      style: AppThemeStyles.white12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: AppDimensions.margin0_10_10_0,
                                                                            child:  parsentage22=="100"? Text("המשימה נסגרת היום בשעה 20:00",style: AppThemeStyles.blackBold14):Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(TenantsLocalizations.of(context)!.find(AppStrings.progress),style: AppThemeStyles.black14),
                                                                                Text("$parsentage22%",style: AppThemeStyles.black14),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(height:AppDimensions.five),
                                                                          Transform.rotate(
                                                                            angle: 180 * math.pi / 180,
                                                                            child: LinearPercentIndicator(
                                                                              // width: MediaQuery.of(context).size.width - 50,
                                                                              animation: true,
                                                                              lineHeight: 10.0,
                                                                              animationDuration: 2500,
                                                                              percent: parsentage33,
                                                                              barRadius:  Radius.circular(AppDimensions.twenty),
                                                                              // ignore: deprecated_member_use
                                                                              linearStrokeCap: LinearStrokeCap.round,
                                                                              progressColor: AppColors.lightGreenColor,
                                                                              backgroundColor: AppColors.skyHighLightColor,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]))),
                                                ),
                                              );
                                            }),
                                    if(controller.projectListModel.data!.futureTasks!.isNotEmpty)
                                      controller.projectListModel.data!.futureTasks!.isEmpty? Container():Text(TenantsLocalizations.of(context)!.find(AppStrings.futureTask),style: TextStyle(
                                        fontFamily: AppFonts.appRubikBoldFontFamily,
                                        fontSize: AppDimensions.twenty,
                                        color: AppColors.blackColor,
                                      )),
                                    // Text(TenantsLocalizations.of(context)!.find(AppStrings.futureTask),style: AppThemeStyles.blackBold18),
                                    controller.projectListModel.data!.futureTasks!.isEmpty? Container():
                                    ListView.builder(
                                        itemCount: controller.projectListModel.data!.futureTasks!.length,
                                        shrinkWrap: true,
                                        controller: controller.scrollController,
                                        itemBuilder: (context,i){
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                AppRouteMaps.goToCloseTaskPage(
                                                    controller.projectListModel.data!.futureTasks![i].id.toString(),
                                                    "future",
                                                  "laawyer"
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:  BorderRadius.circular(AppDimensions.twenty),
                                                    boxShadow:  [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.2), //color of shadow
                                                        spreadRadius: 2, //spread radius
                                                        blurRadius: 5, // blur radius
                                                        offset: const Offset(0, 1),
                                                      )
                                                    ]
                                                ),
                                                child: Padding(
                                                  padding: AppDimensions.margin10_10_20_20,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(AssetsBase.calendarBlueIcon,height: AppDimensions.sixty,width: AppDimensions.sixty),
                                                      SizedBox(width: AppDimensions.ten),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(child: Text(controller.projectListModel.data!.futureTasks![i].task!.name.toString(),style: TextStyle(
                                                                  fontFamily: AppFonts.appRubikMediumFontFamily,
                                                                  fontSize: AppDimensions.eighteen,
                                                                  color: AppColors.blackColor,
                                                                ))),
                                                                Text("0%",style: AppThemeStyles.black14),
                                                              ],
                                                            ),
                                                            SizedBox(height: AppDimensions.five),
                                                            Row(
                                                              children: [
                                                                Text("${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectListModel.data!.futureTasks![i].endDate.toString()))} - ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectListModel.data!.futureTasks![i].startDate.toString()))}",style: AppThemeStyles.black12),
                                                                SizedBox(width: AppDimensions.five),
                                                                Expanded(
                                                                  child: Transform.rotate(
                                                                    angle: 180 * math.pi / 180,
                                                                    child: LinearPercentIndicator(
                                                                      // width: MediaQuery.of(context).size.width - 50,
                                                                      animation: true,
                                                                      lineHeight: 10.0,
                                                                      animationDuration: 2500,
                                                                      percent: 0.0,
                                                                      // center: Text("75.0%"),
                                                                      barRadius:  Radius.circular(AppDimensions.twenty),
                                                                      // ignore: deprecated_member_use
                                                                      linearStrokeCap: LinearStrokeCap.round,
                                                                      progressColor: AppColors.lightGreenColor,
                                                                      backgroundColor: AppColors.skyHighLightColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                        }),
                                    controller.projectListModel.data!.closeTasks!.isEmpty? Container(): Text(TenantsLocalizations.of(context)!.find(AppStrings.futureTask),style: TextStyle(
                                      fontFamily: AppFonts.appRubikBoldFontFamily,
                                      fontSize: AppDimensions.twenty,
                                      color: AppColors.blackColor,
                                    )),
                                    controller.projectListModel.data!.closeTasks!.isEmpty? Container():ListView.builder(
                                        itemCount: controller.projectListModel.data!.closeTasks!.length,
                                        shrinkWrap: true,
                                        controller: controller.scrollController,
                                        itemBuilder: (context,i){
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20
                                            ),
                                            child:   InkWell(
                                              onTap: (){
                                                AppRouteMaps.goToCloseTaskPage(
                                                    controller.projectListModel.data!.closeTasks![i].id.toString(),
                                                    "close",
                                                  "laawyer"
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:  BorderRadius.circular(AppDimensions.twenty),
                                                    boxShadow:  [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.2), //color of shadow
                                                        spreadRadius: 2, //spread radius
                                                        blurRadius: 5, // blur radius
                                                        offset: const Offset(0, 1),
                                                      )
                                                    ]
                                                ),
                                                child: Padding(
                                                  padding: AppDimensions.margin10_10_20_20,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: AppDimensions.sixty,
                                                        width: AppDimensions.sixty,

                                                        decoration:  BoxDecoration(
                                                            color: AppColors.lightGreenColor,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Image.asset(AssetsBase.checkIcon),
                                                        ),

                                                      ),

                                                      SizedBox(width: AppDimensions.ten),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(child: Text(controller.projectListModel.data!.closeTasks![i].task!.name.toString(),style: TextStyle(
                                                                  fontFamily: AppFonts.appRubikMediumFontFamily,
                                                                  fontSize: AppDimensions.eighteen,
                                                                  color: AppColors.blackColor,
                                                                ))),
                                                                Text("100%",style: AppThemeStyles.green14),
                                                              ],

                                                            ),
                                                            SizedBox(height: AppDimensions.five),
                                                            Row(
                                                              children: [
                                                                Text("${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectListModel.data!.closeTasks![i].startDate.toString()))} - ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectListModel.data!.closeTasks![i].endDate.toString()))}",style: AppThemeStyles.black12),
                                                                SizedBox(width: AppDimensions.five),
                                                                Expanded(
                                                                  child: Transform.rotate(
                                                                    angle: 180 * math.pi / 180,
                                                                    child: LinearPercentIndicator(
                                                                      // width: MediaQuery.of(context).size.width - 50,
                                                                      animation: true,
                                                                      lineHeight: 10.0,
                                                                      animationDuration: 2500,
                                                                      percent: 1.0,
                                                                      // center: Text("75.0%"),
                                                                      barRadius:  Radius.circular(AppDimensions.twenty),
                                                                      // ignore: deprecated_member_use
                                                                      linearStrokeCap: LinearStrokeCap.round,
                                                                      progressColor: AppColors.lightGreenColor,
                                                                      backgroundColor: AppColors.skyHighLightColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                          );

                                        }),
                                    SizedBox(height: AppDimensions.twenty),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
      );

    });

  }
}
