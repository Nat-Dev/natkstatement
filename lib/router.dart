import 'package:flutter/material.dart';
import 'package:natkstatement/widget/authen.dart';
import 'package:natkstatement/widget/home.dart';
import 'package:natkstatement/widget/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/home': (BuildContext context) => Home(),
};
