import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandemicncovidtracker/data_layer/location_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_controller.dart';

abstract class SharedPrefHndlrMain {}

class NoUpdate extends SharedPrefHndlrMain {}

class SharedPrefHandler extends SharedPrefHndlrMain {
  SharedPreferences _sharedPreferences;
  UserLocationData _data;
  FirebaseUserController _firebaseUserController;

  SharedPrefHandler() {
    _getSharedPrefs();
    _firebaseUserController = FirebaseUserController();
  }
  _getSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> storeUserLocationData(UserLocationData userLocationData) async {
    await _sharedPreferences.setString("name", userLocationData.name);
    await _sharedPreferences.setString("country", userLocationData.country);
    await _sharedPreferences.setString("uid", userLocationData.uid);
    await _sharedPreferences.setStringList(
        "geoPoint", userLocationData.latLong.toStringList());
    await _sharedPreferences.setString("city", userLocationData.city);
    await _sharedPreferences.setString("mail", userLocationData.mail);
    await _sharedPreferences.setString("state", userLocationData.state);
    await _sharedPreferences.setString(
        "postalCode", userLocationData.postalCode);
    await _sharedPreferences.setString("district", userLocationData.district);
    await _sharedPreferences.setString(
        "streetAddr", userLocationData.streetAddr);
    await _sharedPreferences.setString(
        "countryCode", userLocationData.countryCode);
    await _sharedPreferences.setString("subCity", userLocationData.subCity);
  }

  UserLocationData getUserLocationData() {
    _data = UserLocationData(
      name: _sharedPreferences?.getString("name") ?? "",
      country: _sharedPreferences?.getString("country") ?? "",
      city: _sharedPreferences?.getString("city") ?? "",
      mail: _sharedPreferences?.getString("mail") ?? "",
      uid: _sharedPreferences?.getString("uid") ?? "",
      state: _sharedPreferences?.getString("state") ?? "",
      postalCode: _sharedPreferences?.getString("postalCode") ?? "",
      district: _sharedPreferences?.getString("district") ?? "",
      streetAddr: _sharedPreferences?.getString("streetAddr") ?? "",
      subCity: _sharedPreferences?.getString("subCity") ?? "",
      countryCode: _sharedPreferences?.getString("countryCode") ?? "",
      latLong:
          _sharedPreferences?.getStringList("geoPoint")?.fromStringList() ??
              GeoPoint(0.0, 0.0),
    );

    return _data;
  }

  Future<void> locDiffUpdater(UserLocationData _newLocationData) async {
    UserLocationData _shrd = this.getUserLocationData();
    print("${_shrd.getUserDataMap()}");
    if (!_newLocationData.country.contains(_shrd.country) ||
        !_newLocationData.postalCode.contains(_shrd.postalCode) ||
        !_newLocationData.city.contains(_shrd.city) ||
        !_newLocationData.latLong.latitude
            .compareTo(_shrd.latLong.latitude)
            .sendBool() ||
        !_newLocationData.uid.contains(_shrd.uid) ||
        !_newLocationData.countryCode.contains(_shrd.countryCode) ||
        !_newLocationData.district.contains(_shrd.district) ||
        !_newLocationData.subCity.contains(_shrd.subCity) ||
        !_newLocationData.streetAddr.contains(_shrd.streetAddr) ||
        !_newLocationData.state.contains(_shrd.state)) {
      try {
        await _firebaseUserController.writeUserDate(_newLocationData);
        await this.storeUserLocationData(_newLocationData);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

extension geoPointToList on GeoPoint {
  List<String> toStringList() {
    return [this.latitude.toString(), this.longitude.toString()];
  }
}

extension on List {
  GeoPoint fromStringList() {
    return GeoPoint(double.parse(this[0]), double.parse(this[1]));
  }
}

extension on int {
  bool sendBool() {
    if (this == 0)
      return true;
    else if (this < 0 || this > 0) return false;
  }
}
