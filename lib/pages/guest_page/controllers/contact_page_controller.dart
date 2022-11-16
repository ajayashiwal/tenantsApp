import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../models/app_content_model.dart';
import '../../../network_api/api_interface.dart';
import '../../../network_api/const.dart';
import '../../../network_api/network_util.dart';
import '../../../network_api/toast.dart';

class ContactPageController extends GetxController implements ApiInterface{
  final String link = 'https://tenantshield.page.link/qbvQ';
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String? linkMessage;
  bool isCreatingLink = false;
  Uri? url;
  bool isLoading = false;
  final NetworkUtil networkUtil = NetworkUtil();
  AppContentModel appContentModel=AppContentModel();
  @override
  // ignore: must_call_super
  void onInit() async {
    appContentApi();
    createDynamicLink(true);
  }

// app content Api
  void appContentApi() async {
    isLoading = true;
    update();
    networkUtil.get(Constants.appContent, this );
  }

    Future<void> createDynamicLink(bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://tenantshield.page.link',
      link: Uri.parse(link),
      androidParameters:  const AndroidParameters(
        packageName: 'com.app.tenantshield',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.app.tenantshield',
        minimumVersion: '0',
      ),
    );
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
      if (kDebugMode) {
        print("shortLink...$url");
      }

    } else {
      url = await dynamicLinks.buildLink(parameters);
      if (kDebugMode) {
        print("dynamicLinks...$url");
      }
    }
    linkMessage = url.toString();
      isCreatingLink = false;
      update();
  }

  @override
  void onFailure(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }

  @override
  void onSuccess(data, code) {
    isLoading = false;
    update();
    appContentModel=AppContentModel.fromJson(data);
  }

  @override
  void onTokenExpire(message) {
    ToastManager.errorToast('$message');
    isLoading = false;
    update();
  }
}
