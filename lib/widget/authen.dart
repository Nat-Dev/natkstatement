import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natkstatement/utility/my_style.dart';
import 'package:natkstatement/widget/home.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screenWidth;
  bool redEyeStatus = true;
  String email, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildSignUp(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLogo(),
                  MyStyle().titleH1("Money Recorder"),
                  buildUser(),
                  buildPassword(),
                  buildSignIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Authen Successfully.");
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    } catch (e) {
      String code = e.code;
      String message = e.message;
      print("ERROR : $message CODE: $code");
      loginFailAlert(message);
    }
  }

  void loginFailAlert(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.assignment_late,
              color: Colors.red,
              size: 48.0,
            ),
            title: Text(
              "Can not Sign-in to account.",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  TextButton buildSignUp() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        "Sign Up",
        style: TextStyle(color: MyStyle().lightTheme, fontSize: 16),
      ),
    );
  }

  Container buildSignIn() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            checkAuthen();
          }
        },
        child: Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Username:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          prefixIcon: Icon(Icons.perm_identity),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().darkTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightTheme),
          ),
        ),
        validator: (String value) {
          if ((value.contains('@')) && (value.contains('.'))) {
            return null;
          } else {
            return "Please type your Email in the field.";
          }
        },
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "Password:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: redEyeStatus
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  redEyeStatus = !redEyeStatus;
                });
              }),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().darkTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightTheme),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Please type your Password in the field.";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screenWidth * 0.4,
      child: MyStyle().showLogo(),
    );
  }
}
