import "dart:math" as math;

import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_control_layer/firebase_controller.dart';
import 'package:pandemicncovidtracker/data_control_layer/internet_connection_checker.dart';
import 'package:pandemicncovidtracker/data_layer/connection_status_data.dart';
import 'package:pandemicncovidtracker/events/login_events.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_disconnected.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  InternetChecker _internetChecker;
  FirebaseUserController _firebaseUserController;
  NavigatorState _navigatorState;

  @override
  void initState() {
    _internetChecker = InternetChecker();
    _firebaseUserController = FirebaseUserController.loginCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _navigatorState = Navigator.of(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            transform: GradientRotation(-180 * (math.pi / 180)),
            stops: [5.0, 10, 15.0, 20.0],
            radius: 1.5,
            center: Alignment.bottomRight,
            colors: [
              Colors.green[400],
              Colors.green[500],
              Colors.green[500],
              Colors.black87,
            ],
//            begin: Alignment.topLeft,
//            end: Alignment.bottomLeft,
          ),
        ),
        child: MultiProvider(
          providers: [
            StreamProvider<InternetConnection>(
              create: (BuildContext context) => InternetChecker().stream,
              catchError: (context, error) => error,
            ),
            FutureProvider<LoginEvents>(
              initialData: LoadingLogin(),
              create: (BuildContext context) =>
                  _firebaseUserController.isSignedIn(),
            ),
          ],
          child: Stack(
            alignment: Alignment.bottomCenter,
//          fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Xivah",
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontFamily: "Damion-Regulars",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomRight,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "नमस्ते NAMASTHE",
                      style: TextStyle(
                        fontFamily: "Courgette-Regular",
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              Consumer<LoginEvents>(
                builder: (BuildContext context, LoginEvents fvalue, _) {
                  return Consumer<InternetConnection>(builder:
                      (BuildContext contex, InternetConnection ivalue, _) {
                    if (ivalue is InternetConnectionSuccess &&
                        fvalue is LoggedIn) {
                      Future.delayed(
                          Duration(
                            seconds: 2,
                          ), () async {
                        await _navigatorState.pushReplacementNamed("/home");
                      });
                    } else if (ivalue is InternetConnectionSuccess &&
                        fvalue is NotLoggedIn) {
                      Future.delayed(
                          Duration(
                            seconds: 2,
                          ), () async {
                        await _navigatorState.pushReplacementNamed("/login");
                      });
                    } else if (ivalue is InternetConnectionError) {
                      return InternetDisconnected();
                    }
                    return InternetConnectedWidget();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
