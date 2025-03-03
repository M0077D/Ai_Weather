import 'package:geolocator/geolocator.dart';
import 'package:task1/core/utities/location_helper.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    return await LocationHelper.getCurrentLocation();
  }
}
