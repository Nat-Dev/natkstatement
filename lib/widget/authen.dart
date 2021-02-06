import 'package:flutter/material.dart';
import 'package:natkstatement/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: screen * 0.4,
              child: MyStyle().showLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
