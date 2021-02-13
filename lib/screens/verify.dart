import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natkstatement/widget/home.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Email has been sent to ${user.email} please verify."),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }
}
