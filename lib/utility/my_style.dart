import 'package:flutter/material.dart';

class MyStyle {
  Color themeColor = Color(0xff1976d2);
  Color lightTheme = Color(0xff63a4ff);
  Color darkTheme = Color(0xff004ba0);

  Widget showLogo() => Image.asset('images/logo.png');
  Widget titleH1(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: themeColor,
        ),
      );
  Widget titleH2(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget titleH3(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white54,
        ),
      );

  MyStyle();
}
