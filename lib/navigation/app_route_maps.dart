import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tenants_shield_project/models/contact_list_model.dart';
import 'package:tenants_shield_project/models/info_list_model.dart';
import 'package:tenants_shield_project/models/lawyer_contact_list.dart';
import 'package:tenants_shield_project/models/lawyer_info_list_model.dart';
import 'package:tenants_shield_project/models/message_list_model.dart';
import 'package:tenants_shield_project/models/project_list_model.dart';
import 'package:tenants_shield_project/models/project_stages_model.dart';
import 'package:tenants_shield_project/models/project_task_details_model.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'app_pages.dart';

abstract class AppRouteMaps {

  static void goToFirstPage() {
    Get.offNamed(
      Routes.firstPage,
    );
  }
  static void goToHomePage() {
    Get.offNamed(
      Routes.homepage,
    );
  }
  static void goToRegistrationPage(String messageData) {
    Get.toNamed(
      Routes.registrationPage,
      arguments: [
        {
          "messageData" : messageData

        }
      ]
    );
  }
  static void goToRegistrationPage1(String messageData) {
    Get.offNamed(
      Routes.registrationPage,
        arguments: [
          {
            "messageData" : messageData

          }
        ]
    );
  }
  static void goToPrivacyPolicyPage() {
    Get.toNamed(
      Routes.privacyPolicyPage,
    );
  }
  static void goToInfoArticle(
      InfoListModel model,
      String id,
      ) {
    Get.toNamed(
        Routes.infoArticle,
        arguments: [
          {
            AppStrings.infoListModel:model,
            "id":id
          }
        ]
    );
  }
  static void goToLawyerInfoArticle(
      LawyerInfoListModel model,
      String id,
      ) {
    Get.toNamed(
        Routes.lawyerInfoArticle,
        arguments: [
          {
            AppStrings.lawyerInfoListModel:model,
            "id":id
          }
        ]
    );
  }
  static void goToInfoPdfViewer(String url,String des) {
    Get.toNamed(
      Routes.infoPdfView,
      arguments: [
        {
          AppStrings.pdfUrl:url,
          "des":des

        }
      ]
    );
  }
  static Future<dynamic> goToMessagePage(String notifcationId) async {
    var result = await Get.toNamed(
      Routes.messagePage,
      arguments: [
        {
          "notifcationId":notifcationId
        }
      ]
    );
    return result;
  }
  static Future<dynamic> goToDeleteMessagePage (
      MessageListModel model,
      String id,
      ) async {
    var result = await Get.toNamed(
      Routes.deleteMessagePage,
        arguments: [
          {
            AppStrings.messageListModel:model,
            "id":id
          }
        ]
    );
    return result;
  }
  static void goToAllProjectStage(
      ProjectStagesModel model,
      ) {
    Get.toNamed(
      Routes.allProjectStage,
        arguments: [
          {
            AppStrings.projectStagesModel:model,
          }
        ]
    );
  }
  static void goToLawyerAllProjectStage(
      ProjectListModel model,
      ) {
    Get.toNamed(
        Routes.lawyerAllProjectStage,
        arguments: [
          {
            AppStrings.projectListModel:model,
          }
        ]
    );
  }
  static void goToLoginPage(String type) {
    Get.toNamed(
      Routes.loginPage,
        arguments:[{
          AppStrings.type:type
        }]
    );

  }
  static void goToOtpPage1(String email,String isType,String loginType) {
    Get.toNamed(Routes.otpPage,
        arguments: [{
          AppStrings.email: email,
          AppStrings.isType:AppStrings.login,
          AppStrings.loginType:loginType
        }
        ]);
  }
  static void goToOtpPage(String projectCode,String firstName, String lastName,String email,String phone, String streetName,String buildingName,String apartmentName,
      String imageUrl
      ) {
    Get.toNamed(Routes.otpPage,
    arguments: [{
      AppStrings.projectCode: projectCode,
      AppStrings.firstName: firstName,
      AppStrings.lastName: lastName,
      AppStrings.email: email,
      AppStrings.phone: phone,
      AppStrings.streetName: streetName,
      AppStrings.buildingName: buildingName,
      AppStrings.apartmentName: apartmentName,
      AppStrings.imageUrl:imageUrl
    }
    ]);
  }
  static void goToGeneralInfoPage() {
    Get.toNamed(
      Routes.generalInfoPage,
    );
  }
  static void goToJobsPage() {
    Get.toNamed(
      Routes.jobsPage,
    );
  }
  static void goToContactPage() {
    Get.toNamed(
      Routes.contactPage,
    );
  }


  static void goToGeneralTaskPage(
      String taskInProgressId,
      // String completeTaskId,
      ) {
    Get.toNamed(
      Routes.generalTaskViewPage,
        arguments: [
          {
            "taskInProgressId":taskInProgressId,
          }
        ]
    );
  }
  static void goToLawyerGeneralTaskPage(
      String taskInProgressId,
      // String completeTaskId,
      ) {
    Get.toNamed(
        Routes.lawyerGeneralTaskViewPage,
        arguments: [
          {
            "taskInProgressId":taskInProgressId,
          }
        ]
    );
  }
  static Future<dynamic> goToUpdateProfileDetailsPage() async {
   var result = await Get.toNamed(
      Routes.updateProfileDetails,
    );
   return result;
  }
  static Future<dynamic> goToUpdateLawyerProfileDetailsPage() async {
    var result = await Get.toNamed(
      Routes.updateLawyerProfileDetails,
    );
    return result;
  }
  static void goToUpdateOfficeProfileDetailsPage() {
    Get.toNamed(
      Routes.updateOfficeProfileDetails,
    );

  }
  static void goToDashBoardPage() {
    Get.offNamedUntil(AppStrings.dashBoardPage, (route) => false);
  }
  static void goToGuestPage() {
    Get.offNamedUntil(AppStrings.firstPage, (route) => false);
  }
  static void goToContactInfoPage(
      ContactListModel model,
      String id,
      String type
      ) {
    Get.toNamed(
      Routes.contactInfoPage,
      arguments: [
        {
          AppStrings.name:model,
          "id":id,
          AppStrings.type:type,
        }
      ]
    );
  }
  static void goToLawyerContactInfoPage(
      LawyerContactListModel model,
      String id,
      String type
      ) {
    Get.toNamed(
        Routes.lawyerContactInfoView,
        arguments: [
          {
            AppStrings.name:model,
            "id":id,
            AppStrings.type:type,
          }
        ]
    );
  }
  static Future<dynamic> goToCloseTaskDetailsPage(
      ProjectTaskDetailModel model,
      String type,
      String id,
      String mainType,
      String lawyerTenantType,
      String starImage
      ) async{
    var result = await  Get.toNamed(
      Routes.closeTaskDetailsView,
        arguments: [
          {
            "projectDetailsModel":model,
            "type":type,
            "id":id,
            "mainType":mainType,
            "lawyerTenantType":lawyerTenantType,
            "starImage":starImage
          }
        ]
    );
    return result;

  }
  static Future<dynamic> goToCloseTaskPage(
      String projectTaskId,
      String type,
      String mainType
      ) async{
    var result = await Get.toNamed(
        Routes.closeTaskView,
        arguments: [
          {
            "projectTaskId":projectTaskId,
            "type":type,
            "mainType":mainType
            // "completeTaskId":completeTaskId,
          }
        ]
    );
    return result;

  }

}
