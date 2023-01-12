import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel with ChangeNotifier {
  final Set<Marker> markers = {};

  double _latitude = 37.4352;
  double _longitude = -122.1691;

  final LatLng _initialPosition = const LatLng(37.4352, -122.1691);
  LatLng get initialPosition => _initialPosition;

  double get latitude => _latitude;
  double get longitude => _longitude;

  set latitude(double value) {
    _latitude = value;
    notifyListeners();
  }

  set longitude(double value) {
    _longitude = value;
    notifyListeners();
  }

  setLocation(LatLng location) {
    markers.add(Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(title: 'Your Location'),
      anchor: const Offset(0.5, 2),
    ));
    notifyListeners();
  }
}
