import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pandemicncovidtracker/data_control_layer/firebase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class SideAppDrawer extends StatefulWidget {
  @override
  _SideAppDrawerState createState() => _SideAppDrawerState();
}

class _SideAppDrawerState extends State<SideAppDrawer> {
  FirebaseUserController _firebaseUserController;
  SharedPreferences _sharedPreferences;
  String _mail;
  String _name;
  String _PicUrl;
  @override
  void initState() {
    _firebaseUserController = FirebaseUserController.forLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _firebaseUserController.getUserDetails(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _name = snapshot.data[0];
                  _mail = snapshot.data[1];
                  _PicUrl = snapshot.data[2];
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.indigo),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.scaleDown,
                        placeholder: kTransparentImage,
                        fadeOutCurve: Curves.bounceOut,
                        image: _PicUrl,
                      ),
                    ),
                    accountEmail: Text(
                      _mail,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    accountName: Text(_name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  );
                }
                return Container(
                  child: Text(
                    "Welcome",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text(
                              "Account logout",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14.0),
                            ),
                            content: Text(
                              "Are you sure ?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                            actions: <Widget>[
                              OutlineButton(
                                borderSide: BorderSide(color: Colors.red),
                                onPressed: () async {
                                  _sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  await _firebaseUserController
                                      .signOut()
                                      .then((_) async {
                                    await _sharedPreferences.clear();
                                    Navigator.of(
                                      context,
                                    ).pushNamedAndRemoveUntil("/login",
                                        (Route<dynamic> route) => false);
                                  });
                                },
                                child: Text("Yes"),
                                textColor: Colors.red,
                                splashColor: Colors.red[200],
                              ),
                            ],
                          ));
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Sign out"),
                  ),
                  ListTile(
                    leading: Icon(Icons.beenhere),
                    title: Text("Namasthey"),
                    subtitle: Text("Stay Home, Stay safe !"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
