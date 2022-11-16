import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/lawyer_info_controller.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../../appstyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../tenants_localizations.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class LawyerInfoPageView extends StatelessWidget {
  late  bool connected=false;
  LawyerInfoPageView({Key? key}) : super(key: key);
  var dah=Get.isRegistered<LawyerInfoPageController>()
      ? Get.find<LawyerInfoPageController>()
      : Get.put(LawyerInfoPageController());
  @override
  Widget build(BuildContext context) {
    dah.onInit();
    return GetBuilder<LawyerInfoPageController>(builder: (controller) {
      return  Scaffold(
        appBar: title(TenantsLocalizations.of(context)!.find(AppStrings.informationAndFileDirectory),context),
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
            connected = connectivity != ConnectivityResult.none;
            return connectionMessage(child,connected,context);
          },
          child: Stack(
            children: [
              Padding(
                padding: AppDimensions.marginTopTwenty,
                child: Column(
                  children: [
                    Padding(
                      padding:  AppDimensions.margin0_20_20_0,
                      child: Container(
                        height: AppDimensions.forty,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.ten),
                            color: AppColors.grey6Color
                        ),
                        child: TextFormField(
                          controller: controller.searchController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (v){
                            controller.searchTextAPi(v);
                          },
                          decoration:  InputDecoration(
                              contentPadding:  EdgeInsets.symmetric(horizontal: AppDimensions.twelve,vertical: AppDimensions.six),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              hintText: TenantsLocalizations.of(context)!.find(AppStrings.search),
                              prefixIcon: const Icon(Icons.search_outlined,color: AppColors.lightGreyColor),
                              hintStyle: const TextStyle(
                                  color: AppColors.lightGreyColor
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.twenty),
                    // ignore: unnecessary_null_comparison
                    if (controller.lawyerInfoListModel != null)
                      if (controller.lawyerInfoListModel.data != null)
                        Expanded(
                          child: RefreshIndicator(
                            color: AppColors.blueColor,
                            onRefresh: () async {
                              await Future.delayed(const Duration(seconds: 2));
                              controller.lawyerInfoListApiWithOutLoading("");
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.lawyerInfoListModel.data!.length,
                              separatorBuilder: (context, i){
                                return const Divider();
                              },
                              itemBuilder: (context,i){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          connected == false
                                              ? Container():  AppRouteMaps.goToLawyerInfoArticle
                                            (
                                              controller.lawyerInfoListModel,
                                              controller.lawyerInfoListModel.data![i].id.toString()
                                          );
                                          },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(controller.lawyerInfoListModel.data![i].title,style: AppThemeStyles.mediumBold16),
                                                  SizedBox(height: AppDimensions.five),
                                                  Text(DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.lawyerInfoListModel.data![i].createdAt.toString())),style: AppThemeStyles.black12),
                                                  SizedBox(height: AppDimensions.five),
                                                  Text(controller.lawyerInfoListModel.data![i].description,style: AppThemeStyles.black14,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.skyLightColor,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },

                            ),
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
                    child: const CircularProgressIndicator(color: AppColors.skyLightColor)),
              ):Container()
            ],
          ),
        ),

      );

    });

  }
}
