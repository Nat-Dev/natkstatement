import 'package:flutter/material.dart';
import 'package:natkstatement/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screenWidth;
  double screenHeight;
  String userName, email, password;
  bool redEyeStatus = true;

  Container buildUsername() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextField(
        onChanged: (value) => userName = value.trim(),
        decoration: InputDecoration(
          hintText: "Username:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          helperText: "Type your Username.",
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
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextField(
        onChanged: (value) => email = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          helperText: "Type your Email Address.",
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
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "Password:",
          hintStyle: TextStyle(color: MyStyle().darkTheme),
          helperText: "Your password must be at least 6 characters.",
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
      ),
    );
  }

  Container buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {},
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
    );
  }
}
