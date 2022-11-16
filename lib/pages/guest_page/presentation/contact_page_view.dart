import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/pages/guest_page/controllers/contact_page_controller.dart';
import 'package:tenants_shield_project/tenants_localizations.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../appstyle/app_colors.dart';
import '../../../widgets/action_button_continue.dart';
import '../../../widgets/app_bar.dart';


// ignore: must_be_immutable
class ContactPageView extends StatelessWidget{
  late  bool connected=false;
  ContactPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: appBar(controller.appContentModel.data!=null?controller.appContentModel.data!.appScreen![4].text!.label.toString():"",context),
          body: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                  connected = connectivity != ConnectivityResult.none;
                  return connectionMessage(child,connected,context);
                },
                child: controller.isLoading ? Center(child: SizedBox(
                    height: AppDimensions.twentyFive,
                    width: AppDimensions.twentyFive,
                    child: const CircularProgressIndicator(color: AppColors.skyLightColor))):SingleChildScrollView(
                  child: Padding(
                    padding: AppDimensions.padding20,
                    child: Column(
                      children: [
                        // ignore: unnecessary_null_comparison
                        if(controller.appContentModel!=null)
                          if(controller.appContentModel.data!=null)
                            HtmlWidget(
                              controller.appContentModel.data!.appScreen![4].text!.text.toString(),
                              textStyle: AppThemeStyles.blackHeight14,

                            ),
                        SizedBox(height: AppDimensions.forty),
                        ActionButtonWidget(
                          onTap: (){
                            if (kDebugMode) {
                              print("url..sf..${controller.url}");
                            }
                            share("https://tenantshield.page.link/qbvQ","");

                          },
                          text:  TenantsLocalizations.of(context)!.find(AppStrings.shareTheApp),
                          icon: Icons.share,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      );

    });

  }

  void launchWaze(double lat, double lng) async {
    var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lng
        .toString()}&navigate=yes';
    try {
      bool launched =
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        // ignore: deprecated_member_use
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      // ignore: deprecated_member_use
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  // share app
  Future<void> share(dynamic link,String title)async{
    await FlutterShare.share(
      title: "Property",
      text: title,
      linkUrl: link,
      chooserTitle: "Where You Want to Share",

    );
  }
}
