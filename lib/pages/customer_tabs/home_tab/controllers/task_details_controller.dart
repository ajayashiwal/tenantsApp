import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/models/app_content_model.dart';

import '../../../../appStyle/app_colors.dart';
import '../../../../appStyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../models/project_task_details_model.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';

class CloseTaskDetailsPageController extends GetxController implements ApiInterface{
  late  bool connected=false;
  bool isSelected=false;
  var argumentData = Get.arguments;
  AppContentModel appContentModel=AppContentModel();

  ProjectTaskDetailModel projectTaskDetailModel=ProjectTaskDetailModel();

  String projectId="";
  String taskId="";
  String contractorAndLawyerId="";
  String type="";
  String mainType="";
  String lawyerTenantType="";
  String starImage="";
  Contractors? contractorsData;
  Lawyers? lawyerData;
  bool isLoading = false;
  bool isLoading1 = false;
  final NetworkUtil networkUtil = NetworkUtil();
  // api type and variables
  String? apiType;
  static const appContentApiText = "appContentApi";
  static const completeTaskApiText = "completeTaskApi";

  @override
  void onInit() {
    super.onInit();

    if(appContentModel.data==null) {
      appContentApi();
    }

    projectTaskDetailModel  =argumentData[0]["projectDetailsModel"] as ProjectTaskDetailModel;
    contractorAndLawyerId=argumentData[0]["id"];
    type=argumentData[0]["type"];
    mainType=argumentData[0]["mainType"];
    lawyerTenantType=argumentData[0]["lawyerTenantType"];
    starImage=argumentData[0]["starImage"];

    type=="lawyers"?lawyerData=projectTaskDetailModel.data!.lawyers!.firstWhereOrNull((element)=> element.id.toString()==contractorAndLawyerId):
    contractorsData=projectTaskDetailModel.data!.contractors!.firstWhereOrNull((element)=> element.id.toString()==contractorAndLawyerId);

  }
  // app content Api
  void appContentApi() async {
    apiType=appContentApiText;
    isLoading1 = true;
    update();
    networkUtil.get(Constants.appContent, this);
  }
// complete Task API
  void competeTaskApi(String projectId,String taskId,String projectTaskId,String status,String contractorId) async {
    apiType=completeTaskApiText;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.completeTask, authToken.toString(), this,body: {
        "project_id":projectId,
        "task_id":taskId,
        "project_task_id":projectTaskId,
        "status":status,
        type=="contractors"?"contractor_id":"lawyer_id":contractorId
      });
    });

  }

  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    isLoading1 = false;
    update();
  }

  @override
  void onSuccess(data, code) async{
    switch (apiType) {
      case completeTaskApiText:
        isLoading = false;
        update();
        contractorAndLawyerId.toString()!=(type=="contractors"?projectTaskDetailModel.data!.completeStatus?.contractorId.toString():projectTaskDetailModel.data!.completeStatus?.lawyerId.toString())  ||  projectTaskDetailModel.data!.completeStatus?.status==0 || projectTaskDetailModel.data!.completeStatus?.status==null? chooseDialogue(type=="lawyers"?projectTaskDetailModel.data!.task!.name.toString():projectTaskDetailModel.data!.task!.name.toString(),type=="lawyers"?"תודה שבחרת בעו”ד !":"תודה שבחרת בקבלן !"):AppRouteMaps.goToDashBoardPage();
        break;
      case appContentApiText:
        isLoading1 = false;
        update();
        appContentModel=AppContentModel.fromJson(data);


    }

  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    isLoading1 = false;
    update();
  }
  void chooseDialogue(text,desText) {
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
                  text,
                  style: AppThemeStyles.blackBold16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.twenty),
                Padding(
                  padding: AppDimensions.margin0_10_10_0,
                  child:
                  RichText(
                      textAlign: TextAlign.center,
                      text:  TextSpan(
                        text: desText,
                        style: AppThemeStyles.black16,

                      )),
                ),

                SizedBox(height: AppDimensions.ten),
                Column(
                  children: [
                    Container(
                        height:AppDimensions.one,
                        width: double.infinity,
                        color: Colors.grey.shade400
                    ),
                    InkWell(
                      onTap: () async {
                        AppRouteMaps.goToDashBoardPage();

                      },
                      child: Padding(
                        padding: AppDimensions.padding20,
                        child: Center(
                            child: Text(
                                TenantsLocalizations.of(Get.context!)!.find(AppStrings.close),
                                style: AppThemeStyles.blueBold16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }



}
