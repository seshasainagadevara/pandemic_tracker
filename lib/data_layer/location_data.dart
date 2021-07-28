import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pandemicncovidtracker/data_layer/firebaseusr_data.dart';

class UserLocationData {
  final GeoPoint latLong;
  final String uid;
  final String country;
  final String mail;
  final String name;
  final String city;
  final String countryCode;
  final String postalCode;
  final String district;
  final String subCity;
  final String streetAddr;
  final String state;

  UserLocationData(
      {this.latLong,
      this.uid,
      this.country,
      this.mail,
      this.name,
      this.city,
      this.countryCode,
      this.postalCode,
      this.district,
      this.subCity,
      this.state,
      this.streetAddr});

  factory UserLocationData.fromPositionFuser(
      {Placemark placemark, UserData firebaseUser}) {
    return UserLocationData(
      latLong:
          GeoPoint(placemark.position.latitude, placemark.position.longitude),
      uid: firebaseUser.uid,
      country: placemark.country,
      mail: firebaseUser.mail,
      name: firebaseUser.name,
      city: placemark.locality,
      countryCode: placemark.isoCountryCode,
      postalCode: placemark.postalCode,
      district: placemark.subAdministrativeArea,
      subCity: placemark.subLocality,
      streetAddr: placemark.thoroughfare,
      state: placemark.administrativeArea,
    );
  }

  Map<String, dynamic> getUserDataMap() {
    return {
      "name": name,
      "geoPoint": latLong,
      "mail": mail,
      "country": country,
      "city": city,
      "countryCode": countryCode,
      "postalCode": postalCode,
      "district": district,
      "subCity": subCity,
      "state": state,
      "streetAddress": streetAddr
    };
  }
}
