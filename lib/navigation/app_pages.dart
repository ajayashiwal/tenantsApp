import 'package:get/get.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/bindings/lawyer_contact_info_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/presentation/laywer_contact_info_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/dashboard_bar/dashboard_bar_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/all_project_stage_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/task_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/task_details_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/general_task_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/home_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/lawyer_all_project_stage_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/lawyer_general_task_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/bindings/message_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/task_details_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/task_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/delete_message_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/general_task_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/home_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/lawyer_general_task_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/lawyer_view_all_stages.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/messages_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/view_all_stages.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/bindings/info_article_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/bindings/info_pdf_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/bindings/lawyer_info_article_binding.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/presentation/Info_article_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/presentation/info_pdf_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/presentation/lawyer_Info_article_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/profile_tab/bindings/update_lawyer_details_binding.dart';
import 'package:tenants_shield_project/pages/guest_page/bindings/contact_page_binding.dart';
import 'package:tenants_shield_project/pages/guest_page/bindings/general_info_page_binding.dart';
import 'package:tenants_shield_project/pages/guest_page/bindings/guest_page_binding.dart';
import 'package:tenants_shield_project/pages/guest_page/bindings/jobs_page_binding.dart';
import 'package:tenants_shield_project/pages/guest_page/presentation/contact_page_view.dart';
import 'package:tenants_shield_project/pages/guest_page/presentation/general_info_page_view.dart';
import 'package:tenants_shield_project/pages/guest_page/presentation/jobs_page_view.dart';
import 'package:tenants_shield_project/pages/splash_page/splash_binding.dart';
import 'package:tenants_shield_project/pages/splash_page/splash_view.dart';
import 'package:tenants_shield_project/pages/user_registration/bindings/privacy_policy_page_binding.dart';
import 'package:tenants_shield_project/pages/user_registration/bindings/registration_page_binding.dart';
import 'package:tenants_shield_project/pages/user_registration/presentation/privacy_policy_page_view.dart';
import 'package:tenants_shield_project/pages/user_registration/presentation/registration_page_view.dart';
import '../pages/customer_tabs/contact_tab/bindings/contact_info_binding.dart';
import '../pages/customer_tabs/contact_tab/presentation/contacr_info_view.dart';
import '../pages/customer_tabs/profile_tab/bindings/Update_officedetail_binding.dart';
import '../pages/customer_tabs/profile_tab/bindings/update_details_binding.dart';
import '../pages/customer_tabs/profile_tab/presentation/update_lawyer_profile_details.dart';
import '../pages/customer_tabs/profile_tab/presentation/update_office_detail.dart';
import '../pages/customer_tabs/profile_tab/presentation/update_personal_details.dart';
import '../pages/guest_page/presentation/guest_page_view.dart';
import '../pages/user_login/bindings/login_page_binding.dart';
import '../pages/user_login/bindings/otp_page_binding.dart';
import '../pages/user_login/presentation/login_page_view.dart';
import '../pages/user_login/presentation/otp_page_view.dart';

part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
/// and will be used in the material app.
/// Will be ignored for test since all are static values and would not change.
class AppPages {

  static var transitionDuration = const Duration(
    milliseconds: 250,
  );
  // static const initial = Routes.firstPage;
  // static const initial1 = Routes.dashBoardPage;
  static const initial = Routes.splashPage;

  static final pages = [
    GetPage<dynamic>(
      name: _Paths.splashPage,
      transitionDuration: transitionDuration,
      page:  SplashView.new,
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.firstPage,
      transitionDuration: transitionDuration,
      page: GuestPageView.new,
      binding: GuestPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.homepage,
      transitionDuration: transitionDuration,
      page: HomePageView.new,
      binding: HomePageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.registrationPage,
      transitionDuration: transitionDuration,
      page: RegistrationPageView.new,
      binding: RegistrationPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.privacyPolicyPage,
      transitionDuration: transitionDuration,
      page: PrivacyPolicyView.new,
      binding: PrivacyPolicyPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.loginPage,
      transitionDuration: transitionDuration,
      page: LoginPageView.new,
      binding: LoginPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.otpPage,
      transitionDuration: transitionDuration,
      page: OtpPageView.new,
      binding: OtpPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.infoArticle,
      transitionDuration: transitionDuration,
      page: InfoArticleView.new,
      binding: InfoArticleBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage<dynamic>(
      name: _Paths.infoPdfView,
      transitionDuration: transitionDuration,
      page: InfoPdfWebView.new,
      binding: InfoPdfBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.generalInfoPage,
      transitionDuration: transitionDuration,
      page: GeneralInfoPageView.new,
      binding: GeneralInfoPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.jobsPage,
      transitionDuration: transitionDuration,
      page: JobsPageView.new,
      binding: JobsPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.contactPage,
      transitionDuration: transitionDuration,
      page: ContactPageView.new,
      binding: ContactPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.dashBoardPage,
      transitionDuration: transitionDuration,
      page: DashBoardBarView.new,
      binding: DashBoardPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.updateProfileDetails,
      transitionDuration: transitionDuration,
      page: UpdateProfileDetails.new,
      binding: UpdateProfileDetailPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.updateLawyerProfileDetails,
      transitionDuration: transitionDuration,
      page: UpdateLawyerProfileDetails.new,
      binding: UpdateLawyerProfileDetailPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.updateOfficeProfileDetails,
      transitionDuration: transitionDuration,
      page: UpdateOfficeDetail.new,
      binding: UpdateOfficeProfileDetailPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.contactInfoPage,
      transitionDuration: transitionDuration,
      page: ContactInfoView.new,
      binding: ContactInfoPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.messagePage,
      transitionDuration: transitionDuration,
      page: MessagePageView.new,
      binding: MessagePageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.deleteMessagePage,
      transitionDuration: transitionDuration,
      page: DeleteMessagePageView.new,
      binding: MessagePageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.allProjectStage,
      transitionDuration: transitionDuration,
      page: ViewAppStages.new,
      binding: AllProjectStageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.lawyerContactInfoView,
      transitionDuration: transitionDuration,
      page: LawyerContactInfoView.new,
      binding: LawyerContactInfoPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.lawyerInfoArticle,
      transitionDuration: transitionDuration,
      page: LawyerInfoArticleView.new,
      binding: LawyerInfoArticleBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.generalTaskViewPage,
      transitionDuration: transitionDuration,
      page: GeneralTaskView.new,
      binding: GeneralTaskPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.lawyerAllProjectStage,
      transitionDuration: transitionDuration,
      page: LawyerViewAppStages.new,
      binding: LawyerAllProjectStageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.lawyerGeneralTaskViewPage,
      transitionDuration: transitionDuration,
      page: LawyerGeneralTaskView.new,
      binding: LawyerGeneralTaskPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.closeTaskView,
      transitionDuration: transitionDuration,
      page: CloseTaskView.new,
      binding: CloseTaskPageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.closeTaskDetailsView,
      transitionDuration: transitionDuration,
      page: CloseTaskDetails.new,
      binding: CloseTaskDetailsPageBinding(),
      transition: Transition.fadeIn,
    ),

  ];
}
