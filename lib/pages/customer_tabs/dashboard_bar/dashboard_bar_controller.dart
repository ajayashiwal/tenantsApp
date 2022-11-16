import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/pages/customer_tabs/contact_tab/presentation/lawyer_contact_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/home_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/home_tab/presentation/lawyer_home_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/presentation/lawyer_info_view.dart';
import 'package:tenants_shield_project/pages/customer_tabs/tenants_tab/presentation/lawyer_tenants_view.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import '../../../models/register_model.dart';
import '../../../utils/shared_prefs.dart';
import '../contact_tab/presentation/contact_view.dart';
import '../info_tab/presentation/info_view.dart';
import '../profile_tab/presentation/lawyer_profile_view.dart';
import '../profile_tab/presentation/profile_view.dart';
import '../tenants_tab/presentation/tenants_view.dart';

class DashBoardPageController extends GetxController {
  int tab=2;
   String type='';
  // ignore: prefer_typing_uninitialized_variables
  var profileData;
  String imagesUrl = '';
  RegisterModel registerModel=RegisterModel();

  @override
  void onInit() {
    getProfile();
    getType();
    super.onInit();

  }

  final tabs1=[
   ProfilePageView(),
    TenantsPageView(),
    HomePageView(),
    ContactListPageView(),
    InfoPageView(),
  ];
  final tabs2=[
     LawyerProfileView(),
    LawyerTenantsPageView(),
     LawyerHomePageView(),
    LawyerContactListPageView(),
    LawyerInfoPageView(),
  ];
  void getType() async {
    SharedPreferences.getInstance().then((value) {
      type = value.getString(AppStrings.type)!;
    });
  }
  getProfile() {
    SharedPrefs.getProfileData().then((value) {
      profileData = json.decode(value);
      registerModel = RegisterModel.fromJson(profileData);
      imagesUrl= registerModel.data!.profileImage.toString();
      update();
    });
  }
}
