import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Montserrat',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

final kTextStyleBold = TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
  fontSize: 22
);

final kTextStyleNorm = TextStyle(
  color: Colors.white,
  fontFamily: 'Montserrat',
  fontSize: 22,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.blueAccent,
  // color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final Color? appBackgroundColor = Colors.blue[400];
final MaterialColor appBackgroundMaterialColor = Colors.blue;
const COLOR_DARK_BLUE = Color.fromRGBO(13, 53, 78, 1.0);
const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1.0);
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);
const COLOR_PENDING = Color.fromRGBO(242, 157, 86, 1.0);
const COLOR_DONE = Color.fromRGBO(111, 217, 111, 1.0);
final Color appItemColorWhite = Colors.white;
final Color appItemColorBlue = Colors.blueAccent;
const ITEM_COLOR_BLUE = Color.fromRGBO(68, 138, 255, 1.0);
final Color appBodyColor = Colors.white;
final Color? appItemColorLightGrey = Colors.grey[200];
final EdgeInsets edgePaddingLeft = const EdgeInsets.only(left: 20.0);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    bodyText1: TextStyle(
        color: COLOR_BLACK, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1:
        TextStyle(color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400),
    caption: TextStyle(
        color: COLOR_DARK_BLUE, fontWeight: FontWeight.w700, fontSize: 16),
    labelMedium: TextStyle(
        color: ITEM_COLOR_BLUE, fontWeight: FontWeight.w700, fontSize: 16),
    );

const TextTheme TEXT_THEME_SMALL = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
    bodyText1: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1:
    TextStyle(color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400),
    caption: TextStyle(
      color: COLOR_DARK_BLUE, fontWeight: FontWeight.w700, fontSize: 14),
    labelMedium: TextStyle(
        color: ITEM_COLOR_BLUE, fontWeight: FontWeight.w700, fontSize: 14),
    );