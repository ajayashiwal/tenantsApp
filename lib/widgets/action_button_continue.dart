import 'package:flutter/material.dart';
import '../appstyle/app_colors.dart';
import '../appstyle/app_dimensions.dart';
import '../appstyle/app_theme_styles.dart';

class ActionButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final IconData? icon;

  const ActionButtonWidget({
    Key? key,
     this.onTap,
     this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppDimensions.fifty,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.skyLightColor,
            border: Border.all(
                color: AppColors.whiteColor
            ),
          ),
          child: Padding(
            padding: icon != null? AppDimensions.margin0_20_20_0:AppDimensions.marginZero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null?Icon(icon,color: AppColors.whiteColor):Container(),
                const Spacer(),
                Text(text!,style: AppThemeStyles.white20),
                const Spacer(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
