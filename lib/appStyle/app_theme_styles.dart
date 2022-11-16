import 'package:flutter/material.dart';
import 'package:tenants_shield_project/appstyle/app_colors.dart';
import 'package:tenants_shield_project/appstyle/app_dimensions.dart';
import 'package:tenants_shield_project/appstyle/app_fonts.dart';


abstract class AppThemeStyles {

  static TextStyle black40 = TextStyle(
    fontFamily: AppFonts.appRubikBlackFontFamily,
    fontSize: AppDimensions.thirty,
    color: AppColors.blackColor,
  );
  static TextStyle setCustomTextStyle(
      double fontSize, String fontFamily, Color colorTxt, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: colorTxt,
    );
  }
  static TextStyle black26 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twentySix,
    color: AppColors.blackColor,
  );
  static TextStyle black24 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle black30 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.thirty,
    color: AppColors.blackColor,
  );
  static TextStyle white24 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twentyFour,
    color: AppColors.whiteColor,
  );
  static TextStyle white20 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.whiteColor,
  );
  static TextStyle blue20 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.blueColor,
  );
  static TextStyle black20 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.blackColor,
  );
  static TextStyle black18 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.eighteen,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold20 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold22 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twentyTwo,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold18 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.eighteen,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold17 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.seventeen,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold24 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle blackMedium24 = TextStyle(
    fontFamily: AppFonts.appRubikMediumFontFamily,
    fontSize: AppDimensions.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle blackMedium20 = TextStyle(
    fontFamily: AppFonts.appRubikMediumFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold16 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blackColor,
  );

  static TextStyle white16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.whiteColor,

  );
  static TextStyle whiteHeight16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.whiteColor,
    height: 2

  );
  static TextStyle blueBold20 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twenty,
    color: AppColors.blueColor,
  );
  static TextStyle black16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blackColor,
  );
  static TextStyle red16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.redColor,
  );
  static TextStyle blue16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blueColor,
  );
  static TextStyle blue18 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.eighteen,
    color: AppColors.blueColor,
  );
  static TextStyle blueUnderLine16 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blueColor,
    decoration: TextDecoration.underline,
  );
  static TextStyle blueBold16 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blueColor,
  );
  static TextStyle blueMedium16 = TextStyle(
    fontFamily: AppFonts.appRubikMediumFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blueColor,
  );
  static TextStyle whiteBold16 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.whiteColor,
  );
  static TextStyle whiteMedium16 = TextStyle(
    fontFamily: AppFonts.appRubikMediumFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.whiteColor,
  );
  static TextStyle blueUnderline14 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blueColor,
    decoration: TextDecoration.underline,
  );
  static TextStyle blue14 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blueColor,
  );
  static TextStyle blue12 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.blueColor,
  );
  static TextStyle lightGreenColor12 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.lightGreenColor,
  );
  static TextStyle blueBold14 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blueColor,
  );
  static TextStyle blackHeight14 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blackColor,
    height: 1.5
  );
  static TextStyle black14 = TextStyle(
      fontFamily: AppFonts.appRubikRegularFontFamily,
      fontSize: AppDimensions.forTeen,
      color: AppColors.blackColor,
  );
  static TextStyle green14 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.lightGreenColor,
  );
  static TextStyle black12 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.blackColor,
  );
  static TextStyle black10 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.ten,
    color: AppColors.blackColor,
  );
  static TextStyle white12 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.whiteColor,
  );
  static TextStyle blackBold12 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.blackColor,
  );

  static TextStyle blackBold10 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.ten,
    color: AppColors.blackColor,
  );
  static TextStyle blackBold8 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.eight,
    color: AppColors.blackColor,
  );
  static TextStyle  greyLight10 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.ten,
    color: AppColors.lightGreyColor,
  );
  static TextStyle  greyBold10 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.lightGreyColor,
  );
  static TextStyle greenBold14 = TextStyle(
    fontFamily: AppFonts.appRubikRegularFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.lightGreenColor,
  );
  static TextStyle greenBold141 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.lightGreenColor,
  );
  static TextStyle blueBold141 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blueColor,
  );
  static TextStyle greyBold141 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: Colors.grey,
  );
  static TextStyle greenBold12 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.twelve,
    color: AppColors.lightGreenColor,
  );
  static TextStyle skyBold14 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.skyColor,
  );

  static TextStyle blackBold14 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.forTeen,
    color: AppColors.blackColor,
  );

  static TextStyle mediumBold16 = TextStyle(
    fontFamily: AppFonts.appRubikMediumFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blackColor,
  );

  static TextStyle redBold16 = TextStyle(
    fontFamily: AppFonts.appRubikBoldFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.redColor,
  );
  static TextStyle white15 = const TextStyle(
      color: AppColors.whiteColor,
      fontSize: 15
  );

}
