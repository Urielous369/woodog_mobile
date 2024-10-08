import 'package:flutter/material.dart';

const kScaffoldColor = Color(0xffF4F5F9);
const Color kGrey = const Color(0xff858889);
Color kLightGrey = const Color(0xFFECECEC);
const Color kBlackColor = Colors.black;
Color kLightBlackColor = Colors.black.withOpacity(0.5);
const Color kWhiteColor = Colors.white;
Color kLightWhiteColor = Colors.white.withOpacity(0.5);
const Color kOragneColor = Color(0xfff6a73e);
const Color kPrimaryColor = Color(0xFFDF5604);
const Color kBlueColor = Color(0xFF26AFFF);
const Color kLightOrangeColor = Color(0xFFFDB13A);
const Color kLightGreenColor = Color(0xFF34C759);
const Color kPaleGreenColor = Color(0xFFDAD72E);
const Color kDeepGreenColor = Color(0xFF054D37);
const Color paleGreenColor = Color(0xFF5FB69C);
const Color kInputBgColor = Color(0xFFF0F0F0);

const Color kUnselectedLabelColor = Color(0xFF585871);
Gradient kGradientColor = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kOragneColor,
    kPrimaryColor,
  ],
);
Gradient kGradientPaleGreenColor = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    paleGreenColor,
    kDeepGreenColor,
  ],
);

MaterialColor materialPrimaryColor = const MaterialColor(
  0xFFDF5604, // Replace with your desired color value
  <int, Color>{
    50: Color(0xFFDF5604),
    100: Color(0xFFDF5604),
    200: Color(0xFFDF5604),
    300: Color(0xFFDF5604),
    400: Color(0xFFDF5604),
    500: Color(0xFFDF5604),
    600: Color(0xFFDF5604),
    700: Color(0xFFDF5604),
    800: Color(0xFFDF5604),
    900: Color(0xFFDF5604),
  },
);

final colorScheme = ColorScheme.fromSwatch(
  primarySwatch: const MaterialColor(0xFFDF5604, {
    50: Color(0xFFDF5604),
    100: Color(0xFFDF5604),
    200: Color(0xFFDF5604),
    300: Color(0xFFDF5604),
    400: Color(0xFFDF5604),
    500: Color(0xFFDF5604),
    600: Color(0xFFDF5604),
    700: Color(0xFFDF5604),
    800: Color(0xFFDF5604),
    900: Color(0xFFDF5604),
  }),
);
