import 'package:pandemicncovidtracker/data_layer/location_data.dart';

class FetchLocModel {
  final bool isFetched;
  final UserLocationData userLocationData;
  FetchLocModel(this.isFetched, this.userLocationData);
}
