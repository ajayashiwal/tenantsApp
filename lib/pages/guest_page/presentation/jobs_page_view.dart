import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/pages/guest_page/controllers/jobs_page_controller.dart';
import '../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class JobsPageView extends StatelessWidget {
  late  bool connected=false;
   JobsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsPageController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.whiteColor,
          appBar:appBar(controller.appContentModel.data!=null?controller.appContentModel.data!.appScreen![3].text!.label.toString():"",context),
          body: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
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
                      children: [ // ignore: unnecessary_null_comparison
                        // ignore: unnecessary_null_comparison
                        if(controller.appContentModel!=null)
                          if(controller.appContentModel.data!=null)
                            HtmlWidget(
                              controller.appContentModel.data!.appScreen![3].text!.text.toString(),
                              textStyle: AppThemeStyles.blackHeight14,
                            )
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
}
