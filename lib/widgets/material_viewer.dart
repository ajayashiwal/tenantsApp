import 'package:flutter/material.dart';
import '../appstyle/app_colors.dart';
import '../appstyle/app_dimensions.dart';
import '../appstyle/app_fonts.dart';
import '../appstyle/app_theme_styles.dart';


/// [MaterialViewer] widget show action sheet for Android Devices.
///
class MaterialViewer extends StatelessWidget {
  const MaterialViewer({
    Key? key,
    @required this.buttons,
  }) : super(key: key);

  final List<Map<String, dynamic>>? buttons;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppDimensions.twenty),
          ...List.generate(
            buttons!.length,
                (index) => ListTile(
              leading: (buttons![index]['isCancelButton'] as bool) == false
                  ? Icon(
                buttons![index]['buttonIcon'] as IconData,
                color: AppColors.blackColor,
              )
                  : SizedBox(height: AppDimensions.zero),
              title: Text(
                buttons![index]['buttonName'] as String,
                style: (buttons![index]['isCancelButton'] as bool)
                    ? AppThemeStyles.setCustomTextStyle(AppDimensions.fifTeen,
                    AppFonts.appRubikRegularFontFamily, Colors.black, FontWeight.w900)
                    : null,
              ),
              onTap: buttons![index]['onTap'] as Function()?,
            ),
          ).toList(),
        ],
      ),
    ),
  );
}
