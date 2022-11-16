import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/project_task_details_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';

import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class LawyerGeneralTaskPageController extends GetxController implements ApiInterface{
  late  bool connected=false;
  bool isSelected=false;
  var argumentData = Get.arguments;
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
      case projectTaskDetails:
        isLoading = false;
        update();
        projectTaskDetailModel = ProjectTaskDetailModel.fromJson(data);
        DateTime startingDate=DateTime.parse(projectTaskDetailModel.data!.startDate);
        DateTime endDate=DateTime.parse(projectTaskDetailModel.data!.endDate);
        DateTime currentDate=DateTime.now();
        int dateDifference=endDate.difference(startingDate).inDays;
        Duration dateDiff=currentDate.difference(startingDate);
        parsentage2= (double.parse(((dateDiff.inDays/dateDifference)*100).toStringAsFixed(0))).toStringAsFixed(0);
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

