import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/map_provider.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  late GoogleMapController mapController;
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
              target: context.watch<MapModel>().initialPosition,
              zoom: 11.0,
            ),
            markers: context.watch<MapModel>().marker,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<MapModel>(
              builder: (context, userLocation, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        backgroundColor: Colors.teal[400],
                        onPressed: () {
                          LatLng location = LatLng(
                              userLocation.latitude, userLocation.longitude);
                          mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(location, 17));
                          Provider.of<MapModel>(context, listen: false)
                              .addMarker(location);
                          Provider.of<MapModel>(context, listen: false)
                              .showDialogs("Success",
                                  "Entered location successfully!", context);
                        },
                        child: const Text('Enter'),
                      )),
                  const SizedBox(width: 10),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        backgroundColor: Colors.teal[600],
                        onPressed: () {
                          LatLng location = LatLng(
                              userLocation.latitude, userLocation.longitude);
                          mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(location, 17));
                          Provider.of<MapModel>(context, listen: false)
                              .addMarker(location);
                          Provider.of<MapModel>(context, listen: false)
                              .showDialogs("Success",
                                  "Entered location successfully!", context);
                        },
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
