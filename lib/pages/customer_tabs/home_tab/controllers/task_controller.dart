import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/app_content_model.dart';
import '../../../../models/project_stages_model.dart';
import '../../../../models/project_task_details_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class CloseTaskPageController extends GetxController implements ApiInterface{

  late  bool connected=false;
  ScrollController scrollController=ScrollController();
  bool isSelected=false;
  bool isLoading = false;
  var argumentData = Get.arguments;
  ProjectStagesModel? projectStagesModel;
  String closeTaskId="";
  String completeTaskId="";
  String projectTaskId="";
  String type="";
  String mainType="";
  String starImage="";
  bool isLoading1 = false;

  CloseTasks? closeTasksData;
  final NetworkUtil networkUtil = NetworkUtil();
  AppContentModel appContentModel=AppContentModel();
  ProjectTaskDetailModel projectTaskDetailModel=ProjectTaskDetailModel();

  int listSize = 0;
  int restValue = 0;
  late DateTime date1;
  late DateTime date4;
  late DateTime date2;
  late int date3;
  late Duration date6;
  late double parsentage;
  late String parsentage1;
   String parsentage2="";
   String parsentage22="";
  late double parsentage3;
   double parsentage4=0.0;
   double parsentage33=0.0;
  // api type and variables
  String? apiType;
  static const appContentApiText = "appContentApi";
  static const projectTaskDetailsApi = "projectTaskDetailsApi";
  @override
  void onInit() {
    super.onInit();
    projectTaskId=argumentData[0]["projectTaskId"];
    type=argumentData[0]["type"];
    mainType=argumentData[0]["mainType"];
    projectTaskDetailsModelApi(projectTaskId);
    // appContentApi();


  }
// app content Api
  void appContentApi() async {
    apiType=appContentApiText;
    isLoading = true;
    update();
    networkUtil.get(Constants.appContent, this);
  }
  // project stages Listing  API
  void projectTaskDetailsModelApi(String projectTaskId) async {
    apiType=projectTaskDetailsApi;
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
  Future<void> onSuccess(data, code) async {
    switch (apiType) {
      case projectTaskDetailsApi:
    update();
    if(appContentModel.data==null) {
      appContentApi();
    }
    projectTaskDetailModel = ProjectTaskDetailModel.fromJson(data);
    DateTime date4 = DateTime.now().subtract(const Duration(days: 1));
    DateTime date2 = DateTime.parse(projectTaskDetailModel.data!.endDate);
    Duration date6 = date2.difference(date4);
    parsentage2 = (100 -
        double.parse(((date6.inDays / date2.day) * 100).toStringAsFixed(2)))
        .toStringAsFixed(2);
    parsentage4 =
        1 - double.parse(((date6.inDays / date2.day)).toStringAsFixed(2));
    DateTime startingDate = DateTime.parse(
        projectTaskDetailModel.data!.startDate);
    DateTime endDate = DateTime.parse(projectTaskDetailModel.data!.endDate);
    DateTime currentDate = DateTime.now();
    int dateDifference = endDate
        .difference(startingDate)
        .inDays;
    Duration dateDiff = currentDate.difference(startingDate);
    parsentage22 = (double.parse(
        ((dateDiff.inDays / dateDifference) * 100).round().toStringAsFixed(0)))
        .toStringAsFixed(0);
    parsentage33 = double.parse(parsentage22) / 100;
    int firstMaxValue = 0;
    int firstMaxValuePosition = 0;
    int secondMaxValue = 0;
    int secondMaxValuePosition = 0;
    if (projectTaskDetailModel.data!.lawyers != null) {
      if (projectTaskDetailModel.data!.lawyers!.isNotEmpty) {
        for (int i = 0; i < projectTaskDetailModel.data!.lawyers!.length; i++) {
          int d = projectTaskDetailModel.data!.lawyers![i].chooseByTenantCount;
          if (firstMaxValue < d) {
            firstMaxValue = d;
            firstMaxValuePosition = i;
          }
        }

        if (projectTaskDetailModel.data!.taskId == 1 ||
            projectTaskDetailModel.data!.taskId == 3) {
          for (int i = 0; i <
              projectTaskDetailModel.data!.lawyers!.length; i++) {
            int d = projectTaskDetailModel.data!.lawyers![i]
                .chooseByTenantCount;
            if (secondMaxValue < d && d < firstMaxValue) {
              secondMaxValue = d;
              secondMaxValuePosition = i;
            }
          }
          if (projectTaskDetailModel.data!.lawyers!.length >
              secondMaxValuePosition) {
            projectTaskDetailModel.data!.lawyers![secondMaxValuePosition]
                .isSelected = true;
          }
        }
        projectTaskDetailModel.data!.lawyers![firstMaxValuePosition]
            .isSelected = true;
      }
    }
    if (projectTaskDetailModel.data!.contractors != null) {
      if (projectTaskDetailModel.data!.contractors!.isNotEmpty) {
        for (int i = 0; i <
            projectTaskDetailModel.data!.contractors!.length; i++) {
          int d = projectTaskDetailModel.data!.contractors![i]
              .chooseByTenantCount;
          if (firstMaxValue < d) {
            firstMaxValue = d;
            firstMaxValuePosition = i;
          }
        }

        if (projectTaskDetailModel.data!.taskId == 2 ||
            projectTaskDetailModel.data!.taskId == 4) {
          for (int i = 0; i <
              projectTaskDetailModel.data!.contractors!.length; i++) {
            int d = projectTaskDetailModel.data!.contractors![i]
                .chooseByTenantCount;
            if (secondMaxValue < d && d < firstMaxValue) {
              secondMaxValue = d;
              secondMaxValuePosition = i;
            }
          }
          if (projectTaskDetailModel.data!.contractors!.length >
              secondMaxValuePosition) {
            projectTaskDetailModel.data!.contractors![secondMaxValuePosition]
                .isSelected = true;
          }
        }
        projectTaskDetailModel.data!.contractors![firstMaxValuePosition]
            .isSelected = true;
      }
    }


    break;
      case appContentApiText:
        isLoading = false;
        update();
        appContentModel=AppContentModel.fromJson(data);




    }
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
