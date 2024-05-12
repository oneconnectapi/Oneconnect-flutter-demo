import 'package:flutter/material.dart';


const Color primaryColor = Color(0xffD53F8C);
const Color secondaryColor = Color(0xffD53F8C);
const Color warningColor = Color(0xffcc3300);

const Color primaryShade = Color(0xffD53F8C);
const Color secondaryShade = Color(0xffD53F8C);

const Color pink = Color(0xffD53F8C);

const Color purpleBlue = Color(0xff6b90d8);
const Color lightGreen = Color(0xff0abb91);

LinearGradient primaryGradient = const LinearGradient(
  colors: [primaryColor, primaryShade],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient greyGradient = LinearGradient(
  colors: [Colors.grey.withOpacity(.8), Colors.grey.withOpacity(.5)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient secondaryGradient = const LinearGradient(
  colors: [secondaryColor, secondaryShade],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient connectedGradient = const LinearGradient(
  colors: [purpleBlue, lightGreen],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient disableGradient = LinearGradient(
  colors: [Colors.grey.withOpacity(0.9), Colors.grey],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient primarySecondaryGradient = const LinearGradient(
  colors: [primaryColor, primaryShade, secondaryShade, secondaryColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);


const Color backgroundLight = Color(0xff2B3942);
const Color surfaceLight = Color(0xff2B3942);

const Color backgroundDark = Color(0xff2B3942);
const Color surfaceDark = Color(0xff2B3942);

Color get shadowColor => Colors.black.withOpacity(.05);
