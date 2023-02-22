import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenants_shield_project/appstyle/assets_images.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_article_controller.dart';
import '../../../../appStyle/app_colors.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../navigation/app_route_maps.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../widgets/app_bar.dart';

// ignore: must_be_immutable
class InfoArticleView extends StatelessWidget {
  late  bool connected=false;
  final splitName="";
  InfoArticleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoArticleController>(builder: (controller) {
      return WillPopScope(
        onWillPop: ()async{
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("infoFileId", "");
          Get.back();
          return true;
        },
        child: Scaffold(
          appBar: appBar(TenantsLocalizations.of(context)!.find(AppStrings.informationAndFileDirectory),context),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: Padding(
              padding: AppDimensions.marginTopTwenty,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: AppDimensions.margin0_20_20_0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.data!.title,style: AppThemeStyles.mediumBold16),
                            SizedBox(height: AppDimensions.five),
                            Text(controller.data!.description,style: AppThemeStyles.black14),
                            SizedBox(height: AppDimensions.forty),
                            controller.data!.files==""?const Text(""):  Text(TenantsLocalizations.of(context)!.find(AppStrings.files),style: AppThemeStyles.mediumBold16),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.twenty),
                      for(int i=0; i<controller.splitListName.length; i++)
                        controller.splitListName[i]==""?Container():
                        Column(
                          children: [
                            Padding(
                              padding: AppDimensions.margin0_20_20_0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(
                                    child: Text(
                                        controller.splitListName[i]!="null"?
                                        controller.splitListName[i]:
                                        controller.splitPdfList[i].split('/')[
                                        controller.splitPdfList[i].split('/').length-1].substring(0, controller.splitPdfList[i].split('/')[controller.splitPdfList[i].split('/').length-1].length - 4)
                                        ,style: AppThemeStyles.black16),
                                  ),
                                  SizedBox(
                                    height: AppDimensions.thirtyFive,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap:(){
                                              if (kDebugMode) {
                                                print("Downloading Start...${controller.splitPdfList[i]}");
                                              }
                                              AppRouteMaps.goToInfoPdfViewer(controller.splitPdfList[i],controller.splitListName[i]!="null"?
                                              controller.splitListName[i]:
                                              controller.splitPdfList[i].split('/')[
                                              controller.splitPdfList[i].split('/').length-1].substring(0, controller.splitPdfList[i].split('/')[controller.splitPdfList[i].split('/').length-1].length - 4));
                                            },
                                            child: Image.asset(AssetsBase.seeFileIcon)),
                                        SizedBox(width: AppDimensions.ten),
                                        InkWell(
                                            onTap: (){

                                              if (kDebugMode) {
                                                print("Downloading Start...${controller.splitPdfList[i]}");
                                              }
                                              download(controller.splitPdfList[i]);
                                            },
                                            child: Image.asset(AssetsBase.downloadIcon)),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: AppDimensions.ten),
                            Divider(color: Colors.grey.shade400),
                          ],
                        ),
                    ],
                  ),
                  controller.isLoading ? Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Downloading...${controller.progress}%",style: AppThemeStyles.blackBold16),
                      const SizedBox(height: 20),
                      SizedBox(
                          height: AppDimensions.twentyFive,
                          width: AppDimensions.twentyFive,
                          child: const CircularProgressIndicator(color: AppColors.skyLightColor)),
                    ],
                  )):Container()

                ],
              ),
            ),
          ),

        ),
      );

    });
  }
}
appBar(String title,context){
  return AppBar(
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppDimensions.twenty),
            bottomRight: Radius.circular(AppDimensions.twenty),
          )
      ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.skyHighLightColor,
      title: InkWell(
          onTap: ()async{
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("infoFileId", "");
            Get.back();

          },
          child: Text(title,style: AppThemeStyles.black16)),
      titleSpacing: 0,
      leading: InkWell(
        onTap: ()async{
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("infoFileId", "");
          Get.back();
        },
        child: Padding(
          padding:AppDimensions.margin18_0_0_18,
          child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon)),
        ),
      )
  );
}

Future download(String url) async {
  var status=await Permission.storage.request();
  if(status.isGranted){
    final baseStorage=await getApplicationDocumentsDirectory();

    await FlutterDownloader.enqueue(url: url, savedDir: baseStorage.path,
        saveInPublicStorage: true,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true);
  }else{
    if (kDebugMode) {
      print("Pdf not downloading...");
    }
  }

}
