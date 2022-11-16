import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/controllers/all_project_stages_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class ViewAppStages extends StatelessWidget {
  late  bool connected=false;
  bool isSelected=false;
   ViewAppStages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProjectStageController>(builder: (controller) {
      return Scaffold(
        appBar:appBar(TenantsLocalizations.of(context)!.find(AppStrings.projectStages),context),
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
            connected = connectivity != ConnectivityResult.none;
            return connectionMessage(child,connected,context);
          },
          child:  SingleChildScrollView(
            child: Column(
              children: [
                // ignore: unnecessary_null_comparison
                if (controller.projectStagesModel != null)
                  if (controller.projectStagesModel!.data != null)
                ListView.separated(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    itemCount:controller.projectStagesModel!.data!.stages!.length,
                    separatorBuilder: (context,index){
                      return const Divider(height: 1);
                    },
                    itemBuilder:(context,i){
                      String url=controller.projectStagesModel!.data!.stages![i].stage!.image.toString();
                      String fileName = url.split('.').last;
                      return
                        Container(
                        color: controller.projectStagesModel!.data!.stages![i].status.toString()!="Finished"?(controller.projectStagesModel!.data!.stages![i].status=="Started"?AppColors.skyHighLightColor:Colors.transparent):const Color(0xFFE5F8E8),
                        child:  SizedBox(
                          height: 170,
                          child: Row(
                            children: [
                              SizedBox(
                                width: AppDimensions.seventy,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: AppDimensions.twenty),
                                    Expanded(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${TenantsLocalizations.of(context)!.find(AppStrings.level)} ${i+1}",style:controller.projectStagesModel!.data!.stages![i].status=="Started"?AppThemeStyles.blueBold141:(controller.projectStagesModel!.data!.stages![i].status=="Finished"?AppThemeStyles.greenBold141:AppThemeStyles.greyBold141)),
                                      ],
                                    )),
                                    Text(DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectStagesModel!.data!.stages![i].endDate)),style: AppThemeStyles.greyLight10),
                                    SizedBox(height: AppDimensions.ten),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppDimensions.seventy,
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        VerticalDivider(
                                          thickness: 2,
                                          color: controller.projectStagesModel!.data!.stages![i].status=="Started"?AppColors.blueColor:(controller.projectStagesModel!.data!.stages![i].status=="Finished"?AppColors.lightGreenColor:Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                controller.projectStagesModel!.data!.stages![i].status.toString()=="Started"?
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors.whiteColor,
                                                        borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                        border: Border.all(color: AppColors.skyColor,width: AppDimensions.two)
                                                    ),
                                                    child: Padding(
                                                      padding: AppDimensions.padding10,
                                                      // ignore: unnecessary_null_comparison
                                                      child: controller.projectStagesModel!.data!.stages![i].stage!.image.toString()==null?
                                                      Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                      fileName=="svg"? SizedBox(
                                                        height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                        child: SvgPicture.network(
                                                          controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          color: AppColors.blueColor,
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ),
                                                      ):
                                                      CachedNetworkImage(
                                                        imageUrl: controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                        progressIndicatorBuilder:
                                                            (context, url, downloadProgress) => Center(
                                                            child: SizedBox(
                                                              height: AppDimensions.twenty,width: AppDimensions.twenty,
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress.progress,
                                                                  strokeWidth: 2,
                                                                  color: AppColors.blueColor),
                                                            )),
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty
                                                      ),
                                                    )):
                                                (controller.projectStagesModel!.data!.stages![i].status.toString()=="Finished"?
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors.whiteColor,
                                                        borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                        border: Border.all(color: AppColors.lightGreenColor,width: AppDimensions.two)
                                                    ),
                                                    child: Padding(
                                                      padding: AppDimensions.padding10,
                                                      // ignore: unnecessary_null_comparison
                                                      child:
                                                      // ignore: unnecessary_null_comparison
                                                      controller.projectStagesModel!.data!.stages![i].stage!.image.toString()==null?Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                      fileName=="svg"?  SizedBox(
                                                        height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                        child: SvgPicture.network(
                                                          controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          color: AppColors.lightGreenColor,
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ),
                                                      ):
                                                      CachedNetworkImage(
                                                        imageUrl: controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                        progressIndicatorBuilder:
                                                            (context, url, downloadProgress) => Center(
                                                            child: SizedBox(
                                                              height: AppDimensions.twenty,width: AppDimensions.twenty,
                                                              child: Container(
                                                                padding: const EdgeInsets.all(30.0),

                                                                child: CircularProgressIndicator(
                                                                    value: downloadProgress.progress,
                                                                    strokeWidth: 2,
                                                                    color: AppColors.blueColor
                                                                ),
                                                              ),
                                                            )),
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty
                                                      ),
                                                    )):
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors.whiteColor,
                                                        borderRadius: BorderRadius.circular(AppDimensions.fifty),
                                                        border: Border.all(color: Colors.grey)
                                                    ),
                                                    child: Padding(
                                                      padding: AppDimensions.padding10,
                                                      // ignore: unnecessary_null_comparison
                                                      child:
                                                      // ignore: unnecessary_null_comparison
                                                      controller.projectStagesModel!.data!.stages![i].stage!.image.toString()==null?Image.asset("assets/images/app_icon1.png",height: AppDimensions.thirty,width: AppDimensions.thirty):
                                                      fileName=="svg"?
                                                      SizedBox(
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                        child: SvgPicture.network(
                                                          controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                          semanticsLabel: 'A shark?!',
                                                          // color: AppColors.lightGreenColor,
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty,
                                                          placeholderBuilder: (BuildContext context) => Container(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: const CircularProgressIndicator()),
                                                        ),
                                                      )
                                                            :
                                                      CachedNetworkImage(
                                                        imageUrl: controller.projectStagesModel!.data!.stages![i].stage!.image.toString(),
                                                        progressIndicatorBuilder:
                                                            (context, url, downloadProgress) => Center(
                                                            child: SizedBox(
                                                              height: AppDimensions.twenty,width: AppDimensions.twenty,
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress.progress,
                                                                  strokeWidth: 2,
                                                                  color: AppColors.blueColor),
                                                            )),
                                                          height: AppDimensions.thirty,width: AppDimensions.thirty
                                                      ),
                                                    ))),
                                                controller.projectStagesModel!.data!.stages![i].status=="Started"?Positioned(
                                                  right: 0,top: 0,
                                                  child: CircleAvatar(
                                                    radius: AppDimensions.ten,
                                                    backgroundColor: AppColors.blueColor,
                                                    child: Center(child: Icon(CupertinoIcons.hourglass_tophalf_fill,color: AppColors.whiteColor,size: AppDimensions.fifTeen)),
                                                  ),
                                                ):(controller.projectStagesModel!.data!.stages![i].status=="Finished"?Positioned(
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
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: AppDimensions.five),
                                    Text(controller.projectStagesModel!.data!.stages![i].stage!.name.toString(),style: AppThemeStyles.blue16),
                                    SizedBox(height: AppDimensions.five),
                                    Text("${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectStagesModel!.data!.stages![i].endDate))} - ${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.projectStagesModel!.data!.stages![i].startDate))}",style: AppThemeStyles.greyLight10),
                                    SizedBox(height: AppDimensions.five),
                                    Text("${TenantsLocalizations.of(context)!.find("responsibility")} : ${controller.projectStagesModel!.data!.stages![i].stage!.responsibility.toString()}",style: AppThemeStyles.black14),
                                    SizedBox(height: AppDimensions.ten),
                                    controller.projectStagesModel!.data!.stages![i].stage!.description.toString()!="null"?Expanded(
                                      child: HtmlWidget(
                                        controller.projectStagesModel!.data!.stages![i].stage!.description.toString(),
                                        textStyle: AppThemeStyles.black12,
                                      ),
                                    ):const Text(""),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppDimensions.twenty),
                            ],
                          ),
                        )
                        );
                    }
                        ),
              ],
            ),
          ),


        ),

      );

    });



  }
}
