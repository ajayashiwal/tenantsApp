import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoPdfController extends GetxController {
  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';
  final Completer<PDFViewController> pdfController = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String pdfFlePath="";
  ReceivePort port = ReceivePort();
  var argumentData = Get.arguments;
  String pdfUrl="";
  String des="";
  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var last;
  final Completer<WebViewController> webController = Completer<WebViewController>();
  int progress=0;




  @override
  void onInit() {
    pdfUrl= argumentData[0][AppStrings.pdfUrl];
    des= argumentData[0]["des"];
    if (kDebugMode) {
      print("pdfUrl..$pdfUrl");
    }
    var segments = pdfUrl.split(".");
     last = segments[segments.length-1];
    if (kDebugMode) {
      print("pdfUrl......$last");
    }
    // loadPdf();
    IsolateNameServer.registerPortWithName(port.sendPort, AppStrings.downloaderSendPort);
    port.listen((dynamic data) {
      progress=data[2];
      isLoading = true;
      update();
      DownloadTaskStatus status = data[1];
      if(status==DownloadTaskStatus.complete){
        isLoading = false;
        update();
        if (kDebugMode) {
          print(AppStrings.downloadCompete);
        }
        ToastManager.successToast(AppStrings.downloadCompete);
      }

      if(status==DownloadTaskStatus.failed){
        isLoading = false;
        update();
        ToastManager.errorToast("Failed");
      }
      update();
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.onInit();
  }

  pdfView(String url,bool status) async{
    print(status.toString()+"-----sj");
    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(url),mode: status ? LaunchMode.inAppWebView:LaunchMode.externalApplication);
      }
      else{
        await launchUrl(Uri.parse(url),mode: status ? LaunchMode.inAppWebView:LaunchMode.externalApplication);
      }
    } on Exception{
      EasyLoading.showError('Error while loading');
    }
  }
  //
  // @override
  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }
  static void downloadCallback(String id, DownloadTaskStatus status, int progress){
    final SendPort? send =IsolateNameServer.lookupPortByName(AppStrings.downloaderSendPort);
    send!.send([id,status,progress]);
  }

  Future<String?> downloadAndSavePdf() async {
    if (kDebugMode) {
      print("downloadAndSavePdf");
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    // final file = File(directory.path);
    if (await file.exists()) {
      if (kDebugMode) {
        print("exists");
      }
      return file.path;
    }
    if (kDebugMode) {
      print("NotExists");
    }
    try{
      if (kDebugMode) {
        print("object");
      }
      // final response = await http.get(Uri.parse(sampleUrl));
      // print("object1");
      // print("response.....${response}");
      // await file.writeAsBytes(response.bodyBytes);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/sample.pdf');
      return file.path;
    }
    catch(e){
      if (kDebugMode) {
        print("errror${e.toString()}");
      }
      return null;
    }

  }

  void loadPdf() async {
     final x=await downloadAndSavePdf();
     if(x!=null){
       if (kDebugMode) {
         print("pdfFlePath");
       }
       if (kDebugMode) {
         print(pdfFlePath);
       }
       pdfFlePath=x;
       update();

     }
  }
}
