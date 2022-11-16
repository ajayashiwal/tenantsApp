import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import '../../../../models/info_list_model.dart';
import '../../../../network_api/toast.dart';
import '../../../../utils/app_strings.dart';

class InfoArticleController extends GetxController {
  ReceivePort port = ReceivePort();
  var argumentData = Get.arguments;
  InfoListModel? infoListModel;
  String fileName="";
  String id="";
  Data? data;
  bool isLoading = false;


  List<dynamic> splitPdfList=[];
  List<dynamic> splitListName=[];
  int progress=0;


  @override
  void onInit() {
    infoListModel  =argumentData[0][AppStrings.infoListModel] as InfoListModel;
    id=argumentData[0]["id"];
    data=infoListModel!.data!.firstWhereOrNull((element)=> element.id.toString()==id);
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
