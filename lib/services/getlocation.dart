import 'package:geolocator/geolocator.dart';

class GetLocation {
  late double latitude;
  late double longitude;
  getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      // print(longitude);
    } catch (e) {
      print(e);
    }
  }
}