import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/project_stages_model.dart';
import '../../../../utils/app_strings.dart';

class AllProjectStageController extends GetxController {
  ScrollController scrollController=ScrollController();
  var argumentData = Get.arguments;
  ProjectStagesModel? projectStagesModel;


  @override
  void onInit() {
    super.onInit();
    projectStagesModel  =argumentData[0][AppStrings.projectStagesModel] as ProjectStagesModel;

  }

}
