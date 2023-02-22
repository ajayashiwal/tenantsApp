import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/navigation/app_route_maps.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/task_controller.dart';
import '../../../../appStyle/app_fonts.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_bar.dart';
import 'dart:math' as math;


// ignore: must_be_immutable
class CloseTaskView extends StatelessWidget {
  late  bool connected=false;
  CloseTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CloseTaskPageController>(builder: (controller) {
      return Scaffold(

        appBar: appBar1(TenantsLocalizations.of(context)!.find(AppStrings.task),context),
        body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: Stack(
              children: [
                // ignore: unnecessary_null_comparison
                if(controller.appContentModel!=null)
                  if(controller.appContentModel.data!=null)

                    Column(
                      children: [
                        Padding(
                          padding: AppDimensions.padding20,
                          child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                  padding: AppDimensions.padding10,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(controller.projectTaskDetailModel.data!.task!.name!.toString(),style: AppThemeStyles.blackBold18)),
                                            controller.mainType=="laawyer"?Container(): controller.type=="taskInProgress"? controller.projectTaskDetailModel.data!.completeStatus?.status.toString()=="1"? Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGreenColor,
                                                  borderRadius: BorderRadius.circular(AppDimensions.ten)
                                              ),
                                              child: Padding(
                                                padding: AppDimensions.padding8,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.check_circle_outline,color: AppColors.whiteColor,size:AppDimensions.twenty),
                                                    SizedBox(width: AppDimensions.five),
                                                    Text(TenantsLocalizations.of(context)!.find(AppStrings.missionCompleted),style: AppThemeStyles.white12),
                                                  ],
                                                ),
                                              ),
                                            ):Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.yellowColor,
                                                  borderRadius: BorderRadius.circular(AppDimensions.ten)
                                              ),
                                              child: Padding(
                                                padding: AppDimensions.padding8,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(CupertinoIcons.hourglass_tophalf_fill,color: AppColors.whiteColor,size:AppDimensions.twenty),
                                                    SizedBox(width: AppDimensions.five),
                                                    Text(TenantsLocalizations.of(context)!.find(AppStrings.awaitingExecution),style: AppThemeStyles.white12),
                                                  ],
                                                ),
                                              ),
                                            ):Container()
                                          ],
                                        ),
                                        SizedBox(height: AppDimensions.ten),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color: AppColors.blueColor,size:AppDimensions.twenty),
                                            SizedBox(width: AppDimensions.five),
                                            Text("${TenantsLocalizations.of(context)!.find(AppStrings.unit)} ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectTaskDetailModel.data!.endDate.toString()))}",style: AppThemeStyles.black14),
                                          ],
                                        ),
                                        SizedBox(height: AppDimensions.twenty),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(child:
                                            controller.type=="future"? const SizedBox(
                                              height:0,width: 0,
                                            ):(controller.projectTaskDetailModel.data!.completeUsers!.isEmpty) ?const SizedBox(
                                              height:0,width: 0,
                                            ):SizedBox(
                                              height:50,width: 200,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder: (contex, index){

                                                  int listSize = 0;
                                                  int restValue = 0;
                                                  if (controller.projectTaskDetailModel.data!.completeUsers!.length > 4) {
                                                    listSize = 4;
                                                    restValue = controller.projectTaskDetailModel.data!.completeUsers!.length - listSize;
                                                  } else {
                                                    listSize = controller.projectTaskDetailModel.data!.completeUsers!.length;
                                                  }
                                                  return Stack(
                                                    alignment:Alignment.centerRight,
                                                    children: [
                                                      for (int i = 0; i < listSize; i++)
                                                        i == 0?
                                                        controller.projectTaskDetailModel.data!.completeUsers![i].tenant!.profileImage.toString()=="null"?
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
                                                          // child: Image.network( controller.projectStagesModel.data!.taskInProgress![index].completeUsers![i].tenant!.profileImage.toString()),
                                                        ):
                                                        Container(
                                                          width: AppDimensions.forty,
                                                          height: AppDimensions.forty,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              border: Border.all(
                                                                  width: 0.5, color: AppColors.whiteColor),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(controller.projectTaskDetailModel.data!.completeUsers![i].tenant!.profileImage.toString())
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
                                                                    image: NetworkImage(controller.projectTaskDetailModel.data!.completeUsers![i].tenant!.profileImage.toString())
                                                                )
                                                            ),
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
                                                  );
                                                },

                                              ),
                                            )),

                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: AppDimensions.margin0_10_10_0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.progress),style: AppThemeStyles.black14),
                                                        Text("${controller.type=="taskInProgress"?controller.parsentage22:controller.type=="future"?0:100}%",style: AppThemeStyles.black14),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height:AppDimensions.five),
                                                  Transform.rotate(
                                                    angle: 180 * math.pi / 180,
                                                    child: LinearPercentIndicator(
                                                      animation: true,
                                                      lineHeight: 10.0,
                                                      animationDuration: 2500,
                                                      percent: controller.type=="taskInProgress"?controller.parsentage33:controller.type=="future"?0:1,
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
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: AppDimensions.padding20,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(TenantsLocalizations.of(context)!.find(AppStrings.missionDes),style: AppThemeStyles.blackBold18),
                                      SizedBox(height: AppDimensions.twenty),
                                      HtmlWidget(
                                        controller.projectTaskDetailModel.data!.task!.description.toString(),
                                        textStyle: AppThemeStyles.black12,
                                      ),
                                      Row(
                                        children: [
                                          Text(TenantsLocalizations.of(context)!.find(AppStrings.completedTaskByDate),style: AppThemeStyles.black12),
                                          Text(" ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectTaskDetailModel.data!.endDate.toString()))}",style: AppThemeStyles.blackBold14),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)

                                  const Divider(color: AppColors.lightWhiteColor111,height: 1),
                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)
                                Container(
                                    height: 60,
                                    child: Image.network(controller.appContentModel.data!.generalSetting!.stars.toString())),

                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)
                                  Center(child: Text("חברות אמינות ומובילות",style: AppThemeStyles.blackBold18,)),

                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)
                                  SizedBox(height: AppDimensions.twenty),
                                if(controller.projectTaskDetailModel.data!.contractors!.isNotEmpty)
                                  ListView.separated(
                                    itemCount: controller.projectTaskDetailModel.data!.contractors!.length,
                                    shrinkWrap: true,
                                    controller: controller.scrollController,
                                    itemBuilder: (context,i){
                                      // final List<dynamic> count = controller.projectTaskDetailModel.data!.contractors!.where((c) => c.chooseByTenantCount).toList();

                                      return  InkWell(
                                        onTap:(){
                                          var result =    AppRouteMaps.goToCloseTaskDetailsPage(
                                              controller.projectTaskDetailModel,
                                              "contractors",
                                              controller.projectTaskDetailModel.data!.contractors![i].id.toString(),
                                              controller.type,
                                              controller.mainType,
                                              controller.appContentModel.data!.generalSetting!.stars.toString()


                                          );
                                          // ignore: unrelated_type_equality_checks
                                          if(result==AppStrings.Yes){
                                            controller.projectTaskDetailsModelApi(controller.projectTaskId);
                                            controller.update();

                                          }
                                        },
                                        child: Container(
                                          // color: (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)
                                          //     ?const Color(0xFFFECFAF2):Colors.transparent,
                                          color: controller.mainType=="laawyer"?
                                          (controller.projectTaskDetailModel.data!.contractors![i].isSelected )?const Color(0xfffecfaf2):Colors.white:

                                          // ( (((controller.projectTaskDetailModel.data!.taskId==1) || (controller.projectTaskDetailModel.data!.taskId==3) || (controller.projectTaskDetailModel.data!.taskId==2) || (controller.projectTaskDetailModel.data!.taskId==4)) && controller.projectTaskDetailModel.data!.contractors![i].chooseByTenantCount>0) || (controller.type!="close") && (controller.type!="future"))?const Color(0xFFFECFAF2):Colors.transparent:
                                          (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?const Color(0xfffecfaf2):Colors.transparent,
                                          child: Padding(
                                            padding: AppDimensions.margin20_20_10_10,
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: AppDimensions.sixty,
                                                      // width: AppDimensions.sixty,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xFFE9ECEF)),
                                                          borderRadius: BorderRadius.circular(AppDimensions.ten)
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: CachedNetworkImage(
                                                          imageUrl: controller.projectTaskDetailModel.data!.contractors![i].image.toString(),
                                                          progressIndicatorBuilder:
                                                              (context, url, downloadProgress) => Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: CircularProgressIndicator(
                                                                    value: downloadProgress.progress,
                                                                    color: AppColors.blueColor),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(controller.projectTaskDetailModel.data!.contractors![i].companyName.toString(),style: AppThemeStyles.black14),
                                                    RichText(
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                          style: AppThemeStyles.blackBold14, text: controller.projectTaskDetailModel.data!.contractors![i].subTitle.toString()),
                                                    )
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    controller.mainType=="laawyer"?
                                                    (controller.projectTaskDetailModel.data!.contractors![i].isSelected)?

                                                    // ( (((controller.projectTaskDetailModel.data!.taskId==1) || (controller.projectTaskDetailModel.data!.taskId==3) || (controller.projectTaskDetailModel.data!.taskId==2) || (controller.projectTaskDetailModel.data!.taskId==4)) && controller.projectTaskDetailModel.data!.contractors![i].chooseByTenantCount>0) || (controller.type!="close") && (controller.type!="future"))?
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColors.lightGreenColor,
                                                              borderRadius:  BorderRadius.circular(10),
                                                              border: Border.all(
                                                                  color:  AppColors.lightGreenColor
                                                              )
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(Icons.check_circle_outline,color: AppColors.whiteColor,size:AppDimensions.twentyFour),
                                                                const SizedBox(width: 5),
                                                                // ignore: unrelated_type_equality_checks
                                                                Text("בחירת הקבוצה",style: TextStyle(
                                                                  fontFamily: AppFonts.appRubikBoldFontFamily,
                                                                  fontSize: AppDimensions.twelve,
                                                                  color: AppColors.whiteColor,
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   decoration:  BoxDecoration(
                                                        //       color: AppColors.whiteColor,
                                                        //       borderRadius:  BorderRadius.only(
                                                        //         topLeft:Radius.circular(AppDimensions.ten),
                                                        //         bottomLeft: Radius.circular(AppDimensions.ten),
                                                        //       ),
                                                        //       border: Border.all(
                                                        //           color:  AppColors.lightGreenColor
                                                        //       )
                                                        //
                                                        //   ),
                                                        //   child: Padding(
                                                        //     padding: AppDimensions.padding10,
                                                        //     child: Text(controller.projectTaskDetailModel.data!.contractors![i].chooseByTenantCount.toString(),style: AppThemeStyles.blackBold12),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ):Container():
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:  (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.skyHighLightColor,
                                                              borderRadius:  BorderRadius.only(
                                                                topRight:Radius.circular(AppDimensions.ten),
                                                                bottomRight: Radius.circular(AppDimensions.ten),
                                                              ),
                                                              border: Border.all(
                                                                  color:  (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.blueColor
                                                              )
                                                          ),
                                                          child: Padding(
                                                            padding: (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?
                                                            const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5):
                                                            const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                ((
                                                                    controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && ( controller.projectTaskDetailModel.data!.completeStatus?.status==1))
                                                                    ?  Icon(Icons.check_circle_outline,color: AppColors.whiteColor,size:AppDimensions.twentyFour):Container(), (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?  const SizedBox(width: 5):const SizedBox(width: 0),
                                                                (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?  const SizedBox(width: 5):const SizedBox(width: 0),
                                                                // ignore: unrelated_type_equality_checks
                                                                Text((controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?TenantsLocalizations.of(context)!.find(AppStrings.myChoice):TenantsLocalizations.of(context)!.find(AppStrings.choose),style: ( controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?TextStyle(
                                                                  fontFamily: AppFonts.appRubikBoldFontFamily,
                                                                  fontSize: AppDimensions.twelve,
                                                                  color: AppColors.whiteColor,
                                                                ):AppThemeStyles.blue12),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:  BoxDecoration(
                                                              color: AppColors.whiteColor,
                                                              borderRadius:  BorderRadius.only(
                                                                topLeft:Radius.circular(AppDimensions.ten),
                                                                bottomLeft: Radius.circular(AppDimensions.ten),
                                                              ),
                                                              border: Border.all(
                                                                  color:  (controller.projectTaskDetailModel.data!.completeStatus?.contractorId==controller.projectTaskDetailModel.data!.contractors![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.blueColor
                                                              )

                                                          ),
                                                          child: Padding(
                                                            padding: AppDimensions.padding10,
                                                            child: Text(controller.projectTaskDetailModel.data!.contractors![i].chooseByTenantCount.toString(),style: AppThemeStyles.blackBold12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: AppDimensions.five),
                                                    InkWell(
                                                      onTap:(){
                                                        var result =   AppRouteMaps.goToCloseTaskDetailsPage(
                                                            controller.projectTaskDetailModel,
                                                            "contractors",
                                                            controller.projectTaskDetailModel.data!.contractors![i].id.toString(),
                                                            controller.type,
                                                            controller.mainType,
                                                            controller.appContentModel.data!.generalSetting!.stars.toString()

                                                        );
                                                        // ignore: unrelated_type_equality_checks
                                                        if(result==AppStrings.Yes){
                                                          controller.projectTaskDetailsModelApi(controller.projectTaskId);
                                                          controller.update();

                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfo),style: AppThemeStyles.blueBold14),
                                                          SizedBox(width: AppDimensions.ten),
                                                          Icon(Icons.arrow_back_ios_new,color: AppColors.blueColor,size: AppDimensions.twenty)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) { return const Divider(height: 1); },),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)

                                  const Divider(color: AppColors.lightWhiteColor111,height: 1),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)

                                Container(
                                    height: 60,
                                    child: Image.network(controller.appContentModel.data!.generalSetting!.stars.toString())),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)

                                  SizedBox(height: AppDimensions.ten),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)
                                  Center(child: Text('עו"ד מומחים ומפוקחים',style: AppThemeStyles.blackBold18,)),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)
                                  SizedBox(height: AppDimensions.twenty),
                                if(controller.projectTaskDetailModel.data!.lawyers!.isNotEmpty)
                                  ListView.separated(
                                    itemCount: controller.projectTaskDetailModel.data!.lawyers!.length,
                                    shrinkWrap: true,
                                    controller: controller.scrollController,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context,i){
                                      return  InkWell(
                                        onTap:(){
                                          var result =    AppRouteMaps.goToCloseTaskDetailsPage(
                                              controller.projectTaskDetailModel,
                                              "lawyers",
                                              controller.projectTaskDetailModel.data!.lawyers![i].id.toString(),
                                              controller.type,
                                              controller.mainType,
                                              controller.appContentModel.data!.generalSetting!.stars.toString()

                                          );
                                          // ignore: unrelated_type_equality_checks
                                          if(result==AppStrings.Yes){
                                            controller.projectTaskDetailsModelApi(controller.projectTaskId);
                                            controller.update();

                                          }

                                        },
                                        child: Container(
                                          color: controller.mainType=="laawyer"?
                                          (controller.projectTaskDetailModel.data!.lawyers![i].isSelected)?const Color(0xfffecfaf2):Colors.white
                                          // ((controller.type!="close") && (controller.type!="future"))?const Color(0xFFFECFAF2):Colors.transparent:
                                              :((controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1) ) && (controller.type!="close") && (controller.type!="future")?const Color(0xfffecfaf2):Colors.transparent,
                                          child: Padding(
                                            padding: AppDimensions.margin20_20_10_10,
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      // width: 60,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xFFE9ECEF)),
                                                          borderRadius: BorderRadius.circular(AppDimensions.ten)
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                        // child: Image.asset(AssetsBase.rectangleImage),

                                                        child: CachedNetworkImage(
                                                          imageUrl: controller.projectTaskDetailModel.data!.lawyers![i].profileImage.toString(),
                                                          progressIndicatorBuilder:
                                                              (context, url, downloadProgress) => Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: CircularProgressIndicator(
                                                                    value: downloadProgress.progress,
                                                                    color: AppColors.blueColor),
                                                              )),
                                                        ),
                                                      ),
                                                    ),

                                                    Text(controller.projectTaskDetailModel.data!.lawyers![i].officeInfo!.name.toString(),style: AppThemeStyles.black14),
                                                    Text(controller.projectTaskDetailModel.data!.lawyers![i].officeInfo!.subTitle.toString(),style: AppThemeStyles.blackBold14),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    controller.mainType=="laawyer"?
                                                    (controller.projectTaskDetailModel.data!.lawyers![i].isSelected)?
                                                    // ( ((controller.projectTaskDetailModel.data!.taskId==1) || (controller.projectTaskDetailModel.data!.taskId==3) || (controller.projectTaskDetailModel.data!.taskId==2) || (controller.projectTaskDetailModel.data!.taskId==4)) && controller.projectTaskDetailModel.data!.lawyers![i].chooseByTenantCount>0 && (controller.type!="close") && (controller.type!="future"))?
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColors.lightGreenColor,
                                                              borderRadius:  BorderRadius.circular(10),
                                                              border: Border.all(
                                                                  color:  AppColors.lightGreenColor
                                                              )
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(Icons.check_circle_outline,color: AppColors.whiteColor,size:AppDimensions.twentyFour),
                                                                const SizedBox(width: 5),
                                                                // ignore: unrelated_type_equality_checks
                                                                Text("בחירת הקבוצה",style: TextStyle(
                                                                  fontFamily: AppFonts.appRubikBoldFontFamily,
                                                                  fontSize: AppDimensions.twelve,
                                                                  color: AppColors.whiteColor,
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   decoration:  BoxDecoration(
                                                        //       color: AppColors.whiteColor,
                                                        //       borderRadius:  BorderRadius.only(
                                                        //         topLeft:Radius.circular(AppDimensions.ten),
                                                        //         bottomLeft: Radius.circular(AppDimensions.ten),
                                                        //       ),
                                                        //       border: Border.all(
                                                        //           color:  AppColors.lightGreenColor
                                                        //       )
                                                        //
                                                        //   ),
                                                        //   child: Padding(
                                                        //     padding: AppDimensions.padding10,
                                                        //     child: Text(controller.projectTaskDetailModel.data!.lawyers![i].chooseByTenantCount.toString(),style: AppThemeStyles.blackBold12),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ):Container():
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:  (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.skyHighLightColor,
                                                              borderRadius:  BorderRadius.only(
                                                                topRight:Radius.circular(AppDimensions.ten),
                                                                bottomRight: Radius.circular(AppDimensions.ten),
                                                              ),
                                                              border: Border.all(
                                                                  color:  (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.blueColor
                                                              )
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?
                                                            const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5):
                                                            const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                ((controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id)  && ( controller.projectTaskDetailModel.data!.completeStatus?.status==1))?  Icon(Icons.check_circle_outline,color: AppColors.whiteColor,size:AppDimensions.twentyFour):Container(),
                                                                (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?  const SizedBox(width: 5):const SizedBox(width: 0),
                                                                // ignore: unrelated_type_equality_checks
                                                                Text((controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?TenantsLocalizations.of(context)!.find(AppStrings.myChoice):TenantsLocalizations.of(context)!.find(AppStrings.choose),style: ( controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?TextStyle(
                                                                  fontFamily: AppFonts.appRubikBoldFontFamily,
                                                                  fontSize: AppDimensions.twelve,
                                                                  color: AppColors.whiteColor,
                                                                ):AppThemeStyles.blue12),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:  BoxDecoration(
                                                              color: AppColors.whiteColor,
                                                              borderRadius:  BorderRadius.only(
                                                                topLeft:Radius.circular(AppDimensions.ten),
                                                                bottomLeft: Radius.circular(AppDimensions.ten),
                                                              ),
                                                              border: Border.all(
                                                                  color:  (controller.projectTaskDetailModel.data!.completeStatus?.lawyerId==controller.projectTaskDetailModel.data!.lawyers![i].id) && (controller.projectTaskDetailModel.data!.completeStatus?.status==1)?AppColors.lightGreenColor:AppColors.blueColor
                                                              )

                                                          ),
                                                          child: Padding(
                                                            padding: AppDimensions.padding10,
                                                            child: Text(controller.projectTaskDetailModel.data!.lawyers![i].chooseByTenantCount.toString(),style: AppThemeStyles.blackBold12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: AppDimensions.five),
                                                    InkWell(
                                                      onTap:(){
                                                        var result =   AppRouteMaps.goToCloseTaskDetailsPage(
                                                            controller.projectTaskDetailModel,
                                                            "lawyers",
                                                            controller.projectTaskDetailModel.data!.lawyers![i].id.toString(),
                                                            controller.type,
                                                            controller.mainType,
                                                            controller.appContentModel.data!.generalSetting!.stars.toString()

                                                        );
                                                        // ignore: unrelated_type_equality_checks
                                                        if(result=="Yes"){
                                                          controller.projectTaskDetailsModelApi(controller.projectTaskId);
                                                          controller.update();

                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(TenantsLocalizations.of(context)!.find(AppStrings.moreInfo),style: AppThemeStyles.blueBold14),
                                                          SizedBox(width: AppDimensions.ten),
                                                          Icon(Icons.arrow_back_ios_new,color: AppColors.blueColor,size: AppDimensions.twenty)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );

                                    }, separatorBuilder: (BuildContext context, int index) { return const Divider(height: 1,); },),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                controller.isLoading ?
                Center(child: SizedBox(
                    height: AppDimensions.twentyFive,
                    width: AppDimensions.twentyFive,
                    child: const CircularProgressIndicator(color: AppColors.skyLightColor))):Container()
              ],
            )
        ),
      );

    });
  }
}

