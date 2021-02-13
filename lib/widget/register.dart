import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:natkstatement/screens/verify.dart';
import 'package:natkstatement/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  double screenWidth;
  double screenHeight;
  String userName, email, password;
  bool redEyeStatus = true;

  Container buildUsername() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Username:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          helperText: "Type your Username",
          helperStyle: TextStyle(
            color: MyStyle().darkTheme,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
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
          if (value.isEmpty) {
            return "Please type your Username in the field";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          userName = value.trim();
        },
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          helperText: "Type your Email Address",
          helperStyle: TextStyle(
            color: MyStyle().darkTheme,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.email_outlined),
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
          if (!(value.contains('@') && value.contains('.'))) {
            return "Please type your Email Address in the field";
          } else {
            return null;
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
          helperText: "Your password must be at least 6 characters",
          helperStyle: TextStyle(
            color: MyStyle().darkTheme,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
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
          if (value.length < 6) {
            return "Password must be at least 6 characters";
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

  Container buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print("Username = $userName, Email = $email, Password = $password");
            registerFirebase();
          }
        },
        child: Text(
          "Sign Up",
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

  Future<void> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print("Firebase Initialize Success.");
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        sendEmailAlert();
      } catch (err) {
        String code = err.code;
        String message = err.message;
        print("ERROR : $message CODE: $code");
        registerFailAlert(message);
      }
    });
  }

  void sendEmailAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.assignment_turned_in,
              color: Colors.lightGreenAccent.shade400,
              size: 48.0,
            ),
            title: Text(
              "Send Verification Email",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text("press OK to continue and send email"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => VerifyEmail()));
              },
            )
          ],
        );
      },
    );
  }

  void registerFailAlert(String message) {
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
              "Can not create account.",
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().themeColor,
        title: Text("Register"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/register_bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.07,
              ),
              buildUsername(),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              buildEmail(),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              buildPassword(),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              buildSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
