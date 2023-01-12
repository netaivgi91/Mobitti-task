import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/map_provider.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  late GoogleMapController mapController;

  void reportUserLocation(BuildContext context, LatLng location) {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 17));
    bool success = context.read<MapViewModel>().setLocation(location);
    if (success) {
      showDialogs("Success", "Entered location successfully!", context);
    } else {
      showDialogs("Error", "Failed to enter location!", context);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text('Report'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: context.watch<MapViewModel>().initialPosition,
              zoom: 11.0,
            ),
            markers: context.watch<MapViewModel>().markers,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<MapViewModel>(
              builder: (context, userLocation, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        backgroundColor: Colors.teal[400],
                        onPressed: () => reportUserLocation(
                            context,
                            LatLng(
                                userLocation.latitude, userLocation.longitude)),
                        child: const Text('Enter'),
                      )),
                  const SizedBox(width: 10),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        backgroundColor: Colors.teal[600],
                        onPressed: () => reportUserLocation(
                            context,
                            LatLng(
                                userLocation.latitude, userLocation.longitude)),
                        child: const Text('Exit'),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
