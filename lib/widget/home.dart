import 'package:flutter/material.dart';
import 'package:natkstatement/utility/my_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().themeColor,
        title: Text("Home"),
      ),
    );
  }
}
