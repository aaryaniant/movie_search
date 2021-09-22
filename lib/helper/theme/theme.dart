import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme textTheme = TextTheme();

TextTheme getTextTheme(TextTheme theme) {
  Color baseTextColor = Colors.black;

  return theme.copyWith(
    headline1: GoogleFonts.josefinSans(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: baseTextColor),
    headline2: GoogleFonts.josefinSans(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: baseTextColor),
    headline3: GoogleFonts.josefinSans(
        fontSize: 48, fontWeight: FontWeight.w400, color: baseTextColor),
    headline4: GoogleFonts.josefinSans(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: baseTextColor),
    headline5: GoogleFonts.josefinSans(
        fontSize: 24, fontWeight: FontWeight.w400, color: baseTextColor),
    headline6: GoogleFonts.josefinSans(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.52,
        color: Colors.white),
    subtitle1: GoogleFonts.josefinSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: baseTextColor),
    subtitle2: GoogleFonts.josefinSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: baseTextColor),
    bodyText2: GoogleFonts.josefinSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: baseTextColor),
    bodyText1: GoogleFonts.josefinSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: baseTextColor),
    button: GoogleFonts.josefinSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: baseTextColor),
    caption: GoogleFonts.josefinSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: baseTextColor),
    overline: GoogleFonts.josefinSans(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: baseTextColor),
  );
}

final ButtonThemeData buttonThemeData = ButtonThemeData(
    height: 50,
    buttonColor: Colors.blueAccent,
    textTheme: ButtonTextTheme.primary);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

const Color seaweed = const Color(0xff17d292);
const Color pale_grey = const Color(0xffeef1f7);
const Color squash = const Color(0xfff09b23);
const Color mustard_yellow = const Color(0xffdfc208);
const Color lipstick = const Color(0xffd7143a);
const Color lipstick_two = const Color(0xffc81978);
const Color water_blue = const Color(0xff1995c8);
const Color dark = const Color(0xff2a3045);
const Color white = const Color(0xfff6f6f6);
const Color very_light_pink = const Color(0xffe5e5e5);
const Color blue_blue = const Color(0xff195ec8);
const Color blue_blue_a = const Color(0xff195ec9);
const Color piss_yellow = const Color(0xffd5b627);
const Color goldColor = const Color(0xffb89842);
const Color lightBlack = const Color(0xff2d2d2d);