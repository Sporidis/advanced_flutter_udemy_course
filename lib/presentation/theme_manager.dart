import 'package:advanced_course_udemy/presentation/color_manager.dart';
import 'package:advanced_course_udemy/presentation/font_manager.dart';
import 'package:advanced_course_udemy/presentation/styles_manager.dart';
import 'package:advanced_course_udemy/presentation/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager
          .grey1, // will be used incase of disabled button for example

      //ripple color
      splashColor: ColorManager.primaryOpacity70,
      colorScheme: ThemeData.light().colorScheme.copyWith(
            secondary: ColorManager.grey,
          ),

      // card view theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      // app bar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      ),

      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
      ),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s12),
          ),
        ),
      )),

      // text theme
      textTheme: TextTheme(
        headlineMedium: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        labelMedium: getRegularStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s14),
        labelSmall: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey),
      )

      // input decoration theme (text form field)
      );
}
