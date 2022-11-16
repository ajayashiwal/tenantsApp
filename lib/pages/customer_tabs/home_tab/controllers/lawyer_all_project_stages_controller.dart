import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/project_list_model.dart';
import '../../../../utils/app_strings.dart';

class LawyerAllProjectStageController extends GetxController {
  ScrollController scrollController=ScrollController();
  var argumentData = Get.arguments;
  ProjectListModel? projectListModel;


  @override
  void onInit() {
    super.onInit();
    projectListModel  =argumentData[0][AppStrings.projectListModel] as ProjectListModel;
  }

}
