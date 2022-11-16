import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenants_shield_project/appstyle/app_theme_styles.dart';
import 'package:tenants_shield_project/tenants_localizations.dart';
import '../appstyle/app_colors.dart';
import '../appstyle/app_dimensions.dart';

/// [CupertinoViewer] widget show action sheet for IOS Devises.
///
class CupertinoViewer extends StatelessWidget {
  const CupertinoViewer({
    Key? key,
    @required this.buttons,
  }) : super(key: key);

  final List<Map<String, dynamic>>? buttons;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
    actions: <Widget>[
      ...List.generate(
        buttons!.length,
            (index) => (buttons![index]['isCancleButton'] as bool)
            ? SizedBox(height: AppDimensions.zero)
            : CupertinoActionSheetAction(
          onPressed: buttons![index]['onTap'] as Function(),
          child: Text(buttons![index]['buttonName'] as String),
        ),
      ).toList(),
    ],
    cancelButton: CupertinoActionSheetAction(
      isDestructiveAction: true,
      onPressed: Get.back,
      child: const Text("Cancel"),
    ),
  );
}

// show error messages for fields or button clicks
void showErrorDialogs(String message) {
  Get.dialog(
    barrierDismissible: false,
    AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppColors.lightWhiteColor.withOpacity(0.6),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: AppColors.lightWhiteColor.withOpacity(0.1))

        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppDimensions.twenty),

            Text(
              TenantsLocalizations.of(Get.context!)!.find('errorInTheForm'),
              style: AppThemeStyles.redBold16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.twenty),
            Text(
              TenantsLocalizations.of(Get.context!)!.find('pleaseEnter'),
              style: AppThemeStyles.black16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.ten),
            Text(
              message,
              style: AppThemeStyles.blackBold16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.ten),
            const Divider(color: AppColors.lightGreyColor,height: 1,),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: AppDimensions.padding20,
                child: Center(
                    child: Text(
                        TenantsLocalizations.of(Get.context!)!.find('close'),
                        style: AppThemeStyles.blue16)),
              ),
            ),
          ],
        )),
  );
}
// show error messages for check box
void showCheckBoxErrorDialogs() {
  Get.dialog(
    barrierDismissible: false,
    AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppColors.lightWhiteColor.withOpacity(0.8),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: Colors.transparent)
        ),        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppDimensions.twenty),
            Text(
              TenantsLocalizations.of(Get.context!)!.find('errorInTheForm'),
              style: AppThemeStyles.redBold16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.twenty),
            Text(
              "נא להסכים",
              // TenantsLocalizations.of(Get.context!)!.find('pleaseEnter'),
              style: AppThemeStyles.black16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.ten),
            Text(
              "תנאים ומדיניות פרטיות",
              style: AppThemeStyles.blackBold16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.ten),
            const Divider(color: AppColors.lightGreyColor,height: 1,),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: AppDimensions.padding20,
                child: Center(
                    child: Text(
                        TenantsLocalizations.of(Get.context!)!.find('close'),
                        style: AppThemeStyles.blue16)),
              ),
            ),
          ],
        )),
  );
}
