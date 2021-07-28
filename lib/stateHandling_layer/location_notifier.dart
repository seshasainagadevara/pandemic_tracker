import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pandemicncovidtracker/data_control_layer/firebase_controller.dart';
import 'package:pandemicncovidtracker/data_control_layer/location_Controller.dart';
import 'package:pandemicncovidtracker/data_control_layer/sharedPref_handler.dart';
import 'package:pandemicncovidtracker/data_layer/fetch_loc_data.dart';
import 'package:pandemicncovidtracker/data_layer/firebaseusr_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationNotifier extends ChangeNotifier {
  FirebaseUserController _firebaseUserController;
  SharedPrefHandler _prefHandler;
  SharedPreferences _sharedPreferences;
  FirebaseUser _firebaseUser;
  bool _isLocationFetched;
  bool _isloading;

  String country;

  LocationNotifier() {
    _firebaseUserController = FirebaseUserController();
    _prefHandler = SharedPrefHandler();
    _getUser();
  }
  _getUser() async {
    _firebaseUser = await _firebaseUserController.getUser();
    _sharedPreferences = await SharedPreferences.getInstance();
    _getCountry();
  }

  _getCountry() {
    country = _sharedPreferences.getString("country");
    notifyListeners();
  }

  fetchLocation() async {
    _notifier(true);
    FetchLocModel _loc = await LocationController(
      userData: UserData.fromFUSER(_firebaseUser),
    ).getCurrentLocation();

    if (_loc.isFetched && _loc.userLocationData != null) {
      await _prefHandler.locDiffUpdater(
        _loc.userLocationData,
      );
      country = _sharedPreferences.getString("country");

      _isLocationFetched = true;
      _notifier(false);
    } else if (!_loc.isFetched) {
      print("location error");
      _isLocationFetched = false;
      _notifier(false);
    }
  }

  _notifier(bool res) {
    _isloading = res;
    notifyListeners();
  }

  bool get isLocationFetched => _isLocationFetched;

  bool get isloading => _isloading;
}
