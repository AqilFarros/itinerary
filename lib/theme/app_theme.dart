part of 'theme.dart';

class AppTheme {
  static final double defaultMargin = 12.0;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    hintColor: AppColor.hintColor,
    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.accentColor,
      tertiary: AppColor.blackColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultMargin),
        borderSide: BorderSide(color: AppColor.blackColor),
      ),
      contentPadding: EdgeInsets.all(defaultMargin),
      activeIndicatorBorder: BorderSide(color: AppColor.primaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      hintStyle: AppTextStyle.body.copyWith(color: AppColor.hintColor),
      labelStyle: AppTextStyle.body,
      floatingLabelStyle: AppTextStyle.body,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultMargin),
        ),
      ),
    ),

    

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyle.body,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultMargin),
          borderSide: BorderSide(color: AppColor.blackColor),
        ),
        contentPadding: EdgeInsets.all(defaultMargin),
        activeIndicatorBorder: BorderSide(color: AppColor.primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(defaultMargin),
        ),
        hintStyle: AppTextStyle.body.copyWith(color: AppColor.hintColor),
        labelStyle: AppTextStyle.body,
        floatingLabelStyle: AppTextStyle.body,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyle.displayLarge,
      displaySmall: AppTextStyle.displaySmall,
      titleLarge: AppTextStyle.heading,
      titleMedium: AppTextStyle.heading2,
      titleSmall: AppTextStyle.heading3,
      bodyLarge: AppTextStyle.bodyBold,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.body,
    ),
  );
}
