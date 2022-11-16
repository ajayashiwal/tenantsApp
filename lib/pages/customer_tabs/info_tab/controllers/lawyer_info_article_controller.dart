import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

import '../../../../models/lawyer_info_list_model.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class LawyerInfoArticleController extends GetxController {
  ReceivePort port = ReceivePort();
  var argumentData = Get.arguments;
  LawyerInfoListModel? lawyerInfoListModel;
  String fileName="";
  String id="";
  Data? data;
  int progress=0;
  bool isLoading = false;

  List<dynamic> splitPdfList=[];
  List<dynamic> splitListName=[];

  @override
  void onInit() {
    lawyerInfoListModel  =argumentData[0][AppStrings.lawyerInfoListModel] as LawyerInfoListModel;
    id=argumentData[0]["id"].toString();
    data=lawyerInfoListModel!.data!.firstWhereOrNull((element)=> element.id.toString()==id);
    final splitPdfUrl= data!.files.split(',');
    final splitListNames= data!.fileDescription.split('~');
    for (int i = 0; i < splitPdfUrl.length; i++){
      splitPdfList.add(splitPdfUrl[i]);
      var str = data!.files==""?"":splitPdfList[i].split('/')[splitPdfList[i].split('/').length-1].substring(0, splitPdfList[i].split('/')[splitPdfList[i].split('/').length-1].length - 4);
      if (kDebugMode) {
        print("lajlsdjfsjf...$str");
      }

    }
    for (int i = 0; i < splitListNames.length; i++){
      splitListName.add(splitListNames[i]);
    }
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
  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping(AppStrings.downloaderSendPort);
    super.onClose();

  }
  static void downloadCallback(String id, DownloadTaskStatus status, int progress){
    final SendPort? send =IsolateNameServer.lookupPortByName(AppStrings.downloaderSendPort);
    send!.send([id,status,progress]);
  }
}
