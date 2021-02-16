import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:natkstatement/utility/my_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName, email;

  @override
  void initState() {
    super.initState();
    findUsernameAndEmail();
  }

  Future<Null> findUsernameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          userName = event.displayName;
          email = event.email;
          print("userName = " + userName);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().themeColor,
        title: Text("Home"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: MyStyle().darkTheme),
              accountName: null,
              accountEmail: MyStyle().titleH2(email == null ? "Email" : email),
              currentAccountPicture: Image.asset("images/user.png"),
            ),
            buildSignOut(),
          ],
        ),
      ),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          tileColor: Colors.blueGrey.shade800,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 28,
          ),
          title: MyStyle().titleH2("Sign Out"),
          subtitle: MyStyle().titleH3("Sign out from this account"),
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/authen", (route) => false));
            });
          },
        ),
      ],
    );
  }
}
