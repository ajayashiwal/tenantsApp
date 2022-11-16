import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';

import '../appstyle/app_colors.dart';

class ToastManager {
  static void showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: AppDimensions.sixTeen
    );
  }
  static void errorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: AppDimensions.sixTeen
    );
  }
  static void successToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.lightGreenColor,
        textColor: AppColors.whiteColor,
        fontSize: AppDimensions.sixTeen
    );
  }

  static void warningToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.yellow[300],
        textColor: AppColors.blackColor,
        fontSize: AppDimensions.sixTeen
    );
  }
}
