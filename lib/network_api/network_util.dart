import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:async';
import 'dart:convert';
import 'package:tenants_shield_project/network_api/api_interface.dart';
import 'package:tenants_shield_project/network_api/const.dart';
import 'package:tenants_shield_project/network_api/toast.dart';
import 'package:tenants_shield_project/utils/app_strings.dart';



class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();
    NetworkUtil.internal();

  factory NetworkUtil() => instance;
  final JsonDecoder _decoder = const JsonDecoder();
  Future<dynamic> get(String url, ApiInterface interface) async {
    final ioc = HttpClient();
    var connectivityResult = await (Connectivity().checkConnectivity());

    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    var uri =
    Uri.parse(Constants.baseUrl + url);
    if (kDebugMode) {
      print(uri);
    }
    if (connectivityResult == ConnectivityResult.none) {
      interface.onFailure("");

    }else{
    return http.get(uri, headers: {
      'Accept': 'application/json',
    }).then((response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 401) {
        interface.onTokenExpire(res);
      }
      if (statusCode < 200 || statusCode > 400) {
        interface.onFailure("");
        throw Exception(AppStrings.errorWhileFetchingData);
      }
      if (statusCode == 200) {
        var map = _decoder.convert(res);
        if (map[AppStrings.status] == 1) {
          interface.onSuccess(map, statusCode);
        } else {
          interface.onFailure(map[AppStrings.message]);
          ToastManager.errorToast(map[AppStrings.message]);
        }
      }
    });
  }
  }

  Future<dynamic> getAuth(String url, String token, ApiInterface interface) async{
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    var uri = Uri.parse(Constants.baseUrl + url);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (kDebugMode) {
      print('url--------$uri');
    }
    return http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    ).then((response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 401) {
        interface.onTokenExpire(res);
      }
      if (statusCode < 200 || statusCode > 400) {
        throw Exception(AppStrings.errorWhileFetchingData);
      }
      if (statusCode == 200){
       interface.onSuccess(_decoder.convert(res), statusCode);
        // if(map[AppStrings.status]==1){
        //   interface.onSuccess(map, statusCode);
        // }else if(map[AppStrings.status]==0){
        //     // ToastManager.errorToast(map[AppStrings.message]);
        // }else{
        //
        // }
      }
    });
  }


  Future<dynamic> postHeaderAuth(String url, String token, ApiInterface interface, {body}) async {
    final ioc = HttpClient();
    var connectivityResult = await (Connectivity().checkConnectivity());
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpObj = IOClient(ioc);

    var uri = Uri.parse(Constants.baseUrl + url);
    if (kDebugMode) {
      print('uri $uri');
    }
    // if (connectivityResult == ConnectivityResult.none) {
    //   interface.onFailure(AppStrings.pleaseCheckInternetConnections);
    //
    // }else{
      httpObj.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (kDebugMode) {
        print("statusCode $statusCode");
      }
      if (kDebugMode) {
        print("res $res");
      }
      if (statusCode == 401) {
        interface.onTokenExpire(res);
      }
      if (statusCode == 200 || statusCode == 201) {
        var map=_decoder.convert(res);
        interface.onSuccess(map, statusCode);
        // if(map[AppStrings.status]==1){
        //
        // }else{
        //   throw Exception(AppStrings.errorWhileFetchingData);
        //   // interface.onFailure(map[AppStrings.message]);/
        //   // ToastManager.errorToast(map[AppStrings.message]);
        // }
      }
      if (statusCode < 200 || statusCode > 400) {
        if (kDebugMode) {
          print(res);
        }
        interface.onFailure("");
        throw Exception(AppStrings.errorWhileFetchingData);
      }
    });
  }

  Future<dynamic> post(String url, ApiInterface interface,{body}) async {
    final ioc = HttpClient();
    var connectivityResult = await (Connectivity().checkConnectivity());
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpObj = IOClient(ioc);
    var uri = Uri.parse(Constants.baseUrl + url);
    if (connectivityResult == ConnectivityResult.none) {
      interface.onFailure(AppStrings.pleaseCheckInternetConnections);
    }else{
      httpObj.post(uri, body: body).then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        if (kDebugMode) {
          print('res $res');
        }
        if (statusCode == 401) {
          interface.onTokenExpire(res);
        }
        if (statusCode < 200 || statusCode > 400) {
          interface.onFailure("");
          throw Exception(AppStrings.errorWhileFetchingData);
        }
        if (statusCode == 200 || statusCode == 201) {
          var map=_decoder.convert(res);
          if(map[AppStrings.status]==1){
          interface.onSuccess(map, statusCode);
          }else{

            interface.onFailure(map[AppStrings.message]);
            ToastManager.errorToast(map[AppStrings.message]);
          }
        }
      });
    }
    if (kDebugMode) {
      print(' ${uri.toString()} ${AppStrings.body} $body');
    }


  }


  Future<dynamic> uploadMultipartImage({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    String? otp,
    required String streetName,
    String? projectCode,
    required String buildingName,
    required String apartmentName,
     String? device,
     String? version,
     String? oneSignalId,
    required ApiInterface apiInterface,
    String? imagePath,
    required String url
  }) async {
    var uri = Uri.parse(Constants.baseUrl +url);
    if (kDebugMode) {
      print('url $uri');
    }

    final request = http.MultipartRequest('POST', uri);
    final Map<String, String> headers = {
      "Content-Type": "multipart/form-data"
    };

    request.headers.addAll(headers);
    if (imagePath != null && imagePath !="") {
      final multipartFile =
      await http.MultipartFile.fromPath(AppStrings.profile_image, imagePath);
      request.files.add(multipartFile);
    }
    request.fields[AppStrings.email] = email;
    request.fields[AppStrings.firstName] = firstName;
    request.fields[AppStrings.lastName] = lastName;
    request.fields[AppStrings.phone] = phone;
    request.fields[AppStrings.otp] =otp!;
    request.fields[AppStrings.street_name] = streetName;
    request.fields[AppStrings.project_code] = projectCode!;
    request.fields[AppStrings.building_number] = buildingName;
    request.fields[AppStrings.apartment_number] = apartmentName;
    request.fields[AppStrings.device] = device!;
    request.fields[AppStrings.applicationVersion] = version!;
    request.fields[AppStrings.oneSignalId] = oneSignalId!;
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      print('response  ${response.statusCode} => ${response.body}');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      var map=_decoder.convert(response.body);
      if(map[AppStrings.status]==1){
        apiInterface.onSuccess(map, response.statusCode);
      }else{
        apiInterface.onFailure(map[AppStrings.message]);
        ToastManager.errorToast(map[AppStrings.message]);
      }
    } else {
      apiInterface.onFailure("");
    }
  }


}