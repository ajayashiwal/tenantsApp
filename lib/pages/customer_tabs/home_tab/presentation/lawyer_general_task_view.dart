import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/lawyer_general_task_controller.dart';
import '../../../../appStyle/app_colors.dart';
import '../../../../appStyle/app_dimensions.dart';
import '../../../../appStyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_bar.dart';
import 'dart:math' as math;


// ignore: must_be_immutable
class LawyerGeneralTaskView extends StatelessWidget {
  late  bool connected=false;
  bool checkBox = false;

  LawyerGeneralTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerGeneralTaskPageController>(builder: (controller) {
      return Scaffold(
        appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.task),context),
        body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: Stack(
              children: [
                // ignore: unnecessary_null_comparison
                if(controller.projectTaskDetailModel!=null)
                  if(controller.projectTaskDetailModel.data!=null)
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
                                            Expanded(child: Text(controller.projectTaskDetailModel.data!.task!.name.toString(),style: AppThemeStyles.blackBold18)),
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
                                            if(controller.projectTaskDetailModel.data!.completeUsers!.isNotEmpty)
                                              Expanded(
                                                child: SizedBox(
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
                                                              // child: Image.network( controller.projectStagesModel.data!.taskInProgress![index].completeUsers![i].tenant!.profileImage.toString()),
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
                                                      );
                                                    },

                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: AppDimensions.margin0_10_10_0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(TenantsLocalizations.of(context)!.find(AppStrings.progress),style: AppThemeStyles.black14),
                                                        Text("${controller.parsentage2}%",style: AppThemeStyles.black14),
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
                                                      percent: controller.parsentage3,
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
                            child: Padding(
                              padding: AppDimensions.padding20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(controller.projectTaskDetailModel.data!=null)
                                    Expanded(
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
                                ],
                              ),
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
