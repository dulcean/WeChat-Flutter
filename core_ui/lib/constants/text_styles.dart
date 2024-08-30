import 'package:core_ui/core_ui.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTextStyles {
  static TextStyle normal18 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s18,
    fontWeight: FontWeight.w300,
  );

  static TextStyle bold18 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle button24 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s24,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle medium16 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular14 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bold24 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle light12 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s12,
    fontWeight: FontWeight.w300,
  );

  static TextStyle extraBold32 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s32,
    fontWeight: FontWeight.w800,
  );

  static TextStyle italic20 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static TextStyle lightItalic16 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s16,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
  );

  static TextStyle underline14 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
  );

  static TextStyle strikeThrough18 = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: FontSize.s18,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.lineThrough,
  );
}

class FontSize {
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
}
