import 'package:geolocator/geolocator.dart';
import 'package:pandemicncovidtracker/data_layer/fetch_loc_data.dart';
import 'package:pandemicncovidtracker/data_layer/firebaseusr_data.dart';
import 'package:pandemicncovidtracker/data_layer/location_data.dart';

class LocationController {
  Position _currentPosition;
  UserLocationData userLocationData;
  String _currentCountry;
  Geolocator _geolocator;
  UserData userData;

  LocationController({this.userData}) {
    _geolocator = Geolocator()..forceAndroidLocationManager = true;
  }

  Future<FetchLocModel> getCurrentLocation() async {
    try {
      GeolocationStatus geolocationStatus =
          await _geolocator.checkGeolocationPermissionStatus();
      print(geolocationStatus);
      Position _position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      _currentPosition = _position;
      await _getAddressFromCoords();
      return FetchLocModel(true, userLocationData);
    } catch (e) {
      print("loc error : ${e.toString()}");
      return FetchLocModel(false, null);
    }
  }

  _getAddressFromCoords() async {
    List<Placemark> _placemark =
        await _geolocator.placemarkFromPosition(_currentPosition);
    Placemark _place = _placemark[0];
//
//    _currentCountry = _place.country;
    print(
        "${_place.country + _place.administrativeArea + _place.name + _place.locality + _place.thoroughfare + _place.subAdministrativeArea + _place.subLocality},");

    userLocationData = UserLocationData.fromPositionFuser(
        placemark: _place, firebaseUser: userData);
  }
}
