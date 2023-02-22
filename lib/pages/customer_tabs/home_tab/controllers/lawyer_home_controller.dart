import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/project_list_model.dart';
import '../../../../network_api/api_interface.dart';
import '../../../../network_api/const.dart';
import '../../../../network_api/network_util.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class LawyerHomePageController extends GetxController implements ApiInterface{
  late  bool connected=false;
  int activeStep = 5;
  bool goNext = false;
  bool goPrevious = false;
  int? visibleIndex;
  bool isLoading = false;
  String? projectName;
  String? projectId;
  var message="";

  List<String> projectsList = [];
  List<int> projectsIdList = [];
  List<Projects> projectsListData = [];
  final NetworkUtil networkUtil = NetworkUtil();
  ScrollController scrollController=ScrollController();
  ProjectListModel projectListModel=ProjectListModel();
  String lastUserProjectId="";
  final pageViewController=PageController(viewportFraction: 0.3,initialPage: 2);
  // ignore: non_constant_identifier_names
  int STEPS = 5;
  final pageController = PageController();
  String skillLevel = "עבור קבוצה";
  // api type and variables
  String? apiType;
  static const getProjectsList = "getProjectsList";
  static const projectStagesList = "projectStagesList";
@override
  void onInit() async {
  if(projectListModel.data==null) {
    getProjectList("");
  }
   super.onInit();
}


 // get projects List
  void getProjectList(String projectId) async {
    apiType=getProjectsList;
    isLoading = true;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.homePageData}?last_used_project=$projectId", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }
  // get projects List without loading
  void getWithoutLoadingProjectList(String projectId) async {
    apiType=getProjectsList;
    update();
    SharedPreferences.getInstance().then((value) {
      final authToken = value.getString(AppStrings.token);
      networkUtil.getAuth("${Constants.homePageData}?last_used_project=$projectId", authToken.toString(), this );
      if (kDebugMode) {
        print("Auth Token$authToken");
      }});

  }

  @override
  void onFailure(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) async {

    if (data['status'] == 1) {
      switch (apiType) {
        case projectStagesList:
          isLoading = false;
          update();
          // projectStagesModel = ProjectStagesModel.fromJson(data);
          break;
        case getProjectsList:
          projectListModel = ProjectListModel.fromJson(data);
          projectsListData=projectListModel.data!.projects!;
          isLoading = false;
          update();
          for(int i=0; i<projectListModel.data!.stages!.length; i++){
            if(projectListModel.data!.stages![i].status.toString()=="Started"){
              visibleIndex=projectListModel.data!.stages![i].stageId-1;
              update();
            }
          }

          if(projectsListData.isNotEmpty) {
            if(projectListModel.data!.user!.lastUsedProject!=null){
              lastUserProjectId = projectListModel.data!.user!.lastUsedProject.toString();
              if (kDebugMode) {
                print("lastUserProjectId..$lastUserProjectId");
              }
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(AppStrings.projectId, lastUserProjectId);
            }else{
              lastUserProjectId = projectsListData[0].id.toString();
            }
            var index;
            if(projectsList.isNotEmpty){
              projectsList.clear();
            }
            for (int i = 0; i < projectsListData.length; i++) {
              projectsList.add(projectsListData[i].name!);
              projectsIdList.add(projectsListData[i].id!);
            }
            for(int i=0;i<projectsIdList.length;i++){
              if(lastUserProjectId==projectsIdList[i].toString()){
                index=i;
                break;
              }

            }
            projectName=projectsList[index];
          }
      }

    }else if(data['status'] == 0) {
      isLoading = false;
      update();
      message = data['message'];
      // ToastManager.errorToast('$message');
    }



  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast(message);
    isLoading = false;
    update();
  }
}
