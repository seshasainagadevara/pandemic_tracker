import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/events/login_events.dart';
import 'package:pandemicncovidtracker/stateHandling_layer/firebase_user_notifier.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUserNotifier _firebaseUserNotifier;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _firebaseUserNotifier = FirebaseUserNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavigatorState _navigatorState = Navigator.of(context);
    return ChangeNotifierProvider<FirebaseUserNotifier>(
      create: (BuildContext context) => _firebaseUserNotifier,
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green[600],
                Colors.black87,
                Colors.black87,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Namaste",
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        Text(
                          "to",
                          style: TextStyle(fontSize: 40.0, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Greet .",
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    OutlineButton(
                      onPressed: () {
                        _firebaseUserNotifier.getUser();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.orangeAccent),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                "images/gicon.png",
                              ),
                              height: 35.0,
                              fit: BoxFit.cover,
                              //color: Colors.greenAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'In with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Consumer<FirebaseUserNotifier>(
                builder: (BuildContext context, FirebaseUserNotifier value, _) {
                  print(value.runtimeType);
                  if (value?.loginEvents is LoadingLogin) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black87,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.greenAccent,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    );
                  } else if (value?.loginEvents is ErrorLogin) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "Hint: Check internet! try again.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    );
//                    _showSnackBar();
//
                  } else if (value?.loginEvents is LoggedIn) {
                    Future.delayed(
                      Duration(milliseconds: 300),
                      () async =>
                          await _navigatorState.pushReplacementNamed("/home"),
                    );
                  }
                  return InternetConnectedWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
