import 'package:core_ui/core_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme extends AppTheme {
  static LightTheme? _instance;

  static LightTheme get instance {
    _instance ?? LightTheme._init();
    return _instance!;
  }

  LightTheme._init();

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.primaryColor,
    cardColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: AppTextStyles.normal18,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.size_30),
          )),
    ),
  );
}
