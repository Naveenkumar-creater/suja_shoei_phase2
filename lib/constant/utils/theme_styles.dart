import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// AppColors colors(BuildContext context) =>
//     Theme.of(context).extension<AppColors>()!;
const defaultPadding = 16.0;
const scannerPage=1;
const assetIdPage=2;


const String baseApiUrl = "http://192.168.0.103:3000";

ThemeData themeData(BuildContext context, bool isDarkTheme) {
  return ThemeData(
      // extensions: <ThemeExtension<AppColors>>[
      //   AppColors(
      //     color1: isDarkTheme ? Colors.blue : Colors.green,
      //     color2: isDarkTheme ? Colors.pin`k : Colors.blue,
      //     color3: isDarkTheme ? Colors.yellow : Colors.red,
      //   ),
      // ],
      textTheme: GoogleFonts.lexendTextTheme(Theme.of(context).textTheme).apply(
        bodyColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF303030) : const Color(0xFFECF0F6),
      primaryColor:
          isDarkTheme ? const Color(0xFF25476A) : const Color(0xFF03A9F4),
      // primarySwatch:  isDarkTheme ? Color(0xFF25476A):Color(0xFF03A9F4) ,
      colorScheme: ThemeData().colorScheme.copyWith(
          secondary:
              isDarkTheme ? const Color(0xFF1a1f3c) : const Color(0xFFE8FDFD),
          brightness: isDarkTheme ? Brightness.light : Brightness.dark),
      cardColor: isDarkTheme ? const Color(0xFF424242) : Colors.white,
      canvasColor: isDarkTheme ? const Color(0xFF212121) : Colors.grey[50],
      appBarTheme: AppBarTheme(
          backgroundColor:
              isDarkTheme ? const Color(0xFF212121) : const Color(0xFF25476A),
          titleTextStyle: const TextStyle(color: Colors.white)),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()));
}

// @immutable
// class AppColors extends ThemeExtension<AppColors> {
//   final Color? color1;
//   final Color? color2;
//   final Color? color3;

//   const AppColors({
//     required this.color1,
//     required this.color2,
//     required this.color3,
//   });

//   @override
//   AppColors copyWith({
//     Color? color1,
//     Color? color2,
//     Color? color3,
//   }) {
//     return AppColors(
//       color1: color1 ?? this.color1,
//       color2: color2 ?? this.color2,
//       color3: color3 ?? this.color3,
//     );
//   }

//   @override
//   AppColors lerp(ThemeExtension<AppColors>? other, double t) {
//     if (other is! AppColors) {
//       return this;
//     }
//     return AppColors(
//       color1: Color.lerp(color1, other.color1, t),
//       color2: Color.lerp(color2, other.color2, t),
//       color3: Color.lerp(color3, other.color3, t),
//     );
//   }
// }
