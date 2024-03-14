import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';

ThemeData get appTheme => ThemeData(
      appBarTheme: AppBarTheme(
        color: AppColor.mainPurple,
        titleTextStyle: navigatorKey.currentContext!.textTheme.headlineLarge!
            .copyWith(fontSize: 18, color: AppColor.whiteColor),
        toolbarHeight:
            MediaQuery.of(navigatorKey.currentContext!).size.height * 0.13,
      ),
      scaffoldBackgroundColor: AppColor.whiteColor,
      hintColor: AppColor.hintTextStyleColor,
      fontFamily: 'Manrope',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: AppColor.whiteColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColor.whiteColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: AppColor.whiteColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColor.whiteColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: AppColor.whiteColor,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontFamily: 'Manrope',
          color: AppColor.mainPurple,
        ),
      ),
    );
