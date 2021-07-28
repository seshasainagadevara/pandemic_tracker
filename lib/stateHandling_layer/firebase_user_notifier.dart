import 'package:flutter/foundation.dart';
import 'package:pandemicncovidtracker/data_control_layer/firebase_controller.dart';
import 'package:pandemicncovidtracker/events/login_events.dart';

class FirebaseUserNotifier with ChangeNotifier {
  FirebaseUserController _firebaseUserController;
  LoginEvents _loginEvents;

  FirebaseUserNotifier() {
    _firebaseUserController = FirebaseUserController.forLogIn();
  }

  getUser() async {
    _loginEvents = LoadingLogin();
    notifyListeners();
    _firebaseUserController.signInWithGoogle().then((value) {
      _loginEvents = value;
      notifyListeners();
    });
  }

  LoginEvents get loginEvents => _loginEvents;
}
