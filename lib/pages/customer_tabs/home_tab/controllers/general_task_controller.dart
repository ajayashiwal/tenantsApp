import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../appStyle/app_colors.dart';
import '../../../../appStyle/app_dimensions.dart';
import '../../../../appStyle/app_theme_styles.dart';
import '../../../../models/project_stages_model.dart';
import '../../../../models/project_task_details_model.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';

class GeneralTaskPageController extends GetxController implements ApiInterface{
  late  bool connected=false;
  bool isSelected=false;
  var argumentData = Get.arguments;
  ProjectStagesModel? projectStagesModel;
  ScrollController scrollController=ScrollController();
  String taskInProgressId="";
  int listSize = 0;
  int restValue = 0;
  late DateTime date1;
  late DateTime date4;
  late DateTime date2;
  late int date3;
  late Duration date6;
  late double parsentage;
  late String parsentage1;
  late String parsentage2;
  late double parsentage3;
  String projectTaskId="";
  bool isLoading = false;
  double parsentage4=0.0;
  final NetworkUtil networkUtil = NetworkUtil();
  ProjectTaskDetailModel projectTaskDetailModel=ProjectTaskDetailModel();
  String? apiType;
  static const competeTask = "competeTask";
  static const projectTaskDetails = "projectTaskDetails";



  @override
  void onInit() {
    super.onInit();
    projectTaskId=argumentData[0]["taskInProgressId"];
    projectTaskDetailsModelApi(projectTaskId);
  }

  // complete Task API
  void competeTaskApi(String projectId,String taskId,String projectTaskId,String status) async {
    apiType=competeTask;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.completeTask, authToken.toString(), this,body: {
        "project_id":projectId,
        "task_id":taskId,
        "project_task_id":projectTaskId,
        "status":status
      });
    });

  }
  // project stages Listing  API
  void projectTaskDetailsModelApi(String projectTaskId) async {
    apiType=projectTaskDetails;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.postHeaderAuth(Constants.projectTaskDetail, authToken.toString(), this,body: {
        "project_task_id":projectTaskId
      } );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    switch (apiType) {
      case competeTask:
    isLoading = false;
    update();
    projectTaskDetailModel.data!.completeStatus?.status.toString()=="1"?AppRouteMaps.goToDashBoardPage():chooseDialogue(projectTaskDetailModel.data!.task!.name.toString());
    break;
      case projectTaskDetails:
        isLoading = false;
        update();
        projectTaskDetailModel = ProjectTaskDetailModel.fromJson(data);
        DateTime startingDate=DateTime.parse(projectTaskDetailModel.data!.startDate);
        DateTime endDate=DateTime.parse(projectTaskDetailModel.data!.endDate);
        DateTime currentDate=DateTime.now();
        int dateDifference=endDate.difference(startingDate).inDays;
        Duration dateDiff=currentDate.difference(startingDate);
        parsentage2= (double.parse(((dateDiff.inDays/dateDifference)*100).round().toStringAsFixed(0))).toStringAsFixed(0);
        parsentage3=double.parse(parsentage2)/100;

  }
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
void chooseDialogue(text) {
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
                      text: TenantsLocalizations.of(Get.context!)!.find(AppStrings.thankYouForCompletingTheTask),
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
                    onTap: (){
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




