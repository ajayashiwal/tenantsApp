import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/pages/customer_tabs/info_tab/controllers/info_pdf_controller.dart';
import 'package:tenants_shield_project/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../appstyle/app_dimensions.dart';
import '../../../../appstyle/app_theme_styles.dart';
import '../../../../appstyle/assets_images.dart';
import '../../../../tenants_localizations.dart';
import '../../../../utils/app_strings.dart';


// ignore: must_be_immutable
class InfoPdfWebView extends StatelessWidget {
  late  bool connected=false;
  InfoPdfWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoPdfController>(builder: (controller) {
      // controller.last=="pdf"? controller.pdfView(controller.pdfUrl,true):controller.pdfView(controller.pdfUrl,false);
      return  Scaffold(
          bottomNavigationBar: Container(
            height: AppDimensions.eighty,
            color: AppColors.blackColor,
          ),
          appBar: PreferredSize(
            preferredSize:  Size.fromHeight(AppDimensions.eighty),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.blackColor,
              title:  Text(controller.des,style: AppThemeStyles.white16,overflow: TextOverflow.ellipsis,maxLines: 2,),
              leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Padding(
                  padding: AppDimensions.margin18_0_0_18,
                  child: Image.asset(TenantsLocalizations.of(context)!.find(AppStrings.backIcon),color: AppColors.whiteColor),
                ),
              ),
              actions: [
                InkWell(
                    onTap: (){
                      if (kDebugMode) {
                        print("Downloading Start");
                      }
                      download(controller.pdfUrl);
                    },
                    child: Padding(
                      padding: AppDimensions.padding12,
                      child: Image.asset(AssetsBase.downloadIcon1,color: AppColors.whiteColor),
                    )),
              ],
            ),
          ),
          body:  OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              connected = connectivity != ConnectivityResult.none;
              return connectionMessage(child,connected,context);
            },
            child: Stack(
              children: [

                controller.last=="pdf"?
                const PDF(
                  swipeHorizontal: false,
                ).cachedFromUrl(controller.pdfUrl):

                // Container():
                // SfPdfViewer.network(controller.pdfUrl):
                WebView(
                  initialUrl: controller.pdfUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: controller.webController.complete,
                ),
                controller.isLoading ? Center(child: Container(
                  color: Colors.red,
                  child: Column(
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
                  ),
                )):Container(),


              ],
            )
          )
      );
    }
    );
  }
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
