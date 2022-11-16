import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appstyle/app_colors.dart';
import '../appstyle/app_dimensions.dart';
import '../appstyle/app_theme_styles.dart';

 selectImagePickerDialog(String selectImageSource,Image cameraIcon,Image galleryIcon,String cameraText,String galleryText, VoidCallback cameraOnTap,VoidCallback galleryOnTap) {
   Get.dialog(
     AlertDialog(
         contentPadding: EdgeInsets.zero,
         backgroundColor: AppColors.lightWhiteColor,
         shape: const OutlineInputBorder(
             borderSide:  BorderSide(color: Colors.white)
         ),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               decoration: BoxDecoration(
                   color: AppColors.whiteColor,
                   boxShadow: [
                     BoxShadow(
                       color: AppColors.blackColor.withOpacity(0.1),
                       blurRadius: 5.0,
                     ),]
               ),
               width: double.infinity,
               padding: AppDimensions.margin10_10_20_20,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(selectImageSource,style: AppThemeStyles.black16),
                 ],
               ),
             ),
             SizedBox(height: AppDimensions.ten),
             // ignore: deprecated_member_use
             FlatButton.icon(
               icon: cameraIcon,
               onPressed:(){
                 cameraOnTap;
               },
               label:  Text(cameraText,style: AppThemeStyles.blue14),
             ),
             // ignore: deprecated_member_use
             FlatButton.icon(
               icon: galleryIcon,
               onPressed: (){
                 galleryOnTap;
               },
               label:  Text(galleryText,style: AppThemeStyles.blue14),
             ),
             SizedBox(height: AppDimensions.ten),
           ],
         )),
   );}