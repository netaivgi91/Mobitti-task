import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel with ChangeNotifier {
  final Set<Marker> marker = {};

  double _latitude = 37.4352;
  double _longitude = -122.1691;

  late GoogleMapController mapController;

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

  void addMarker(LatLng location) {
    marker.add(Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(title: 'Your Location'),
      anchor: const Offset(0.5, 2),
    ));
    notifyListeners();
  }

  void showDialogs(String title, String content, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
