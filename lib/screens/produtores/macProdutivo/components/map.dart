import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var location = Location();

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0), // Posição inicial do mapa
          zoom: 10.0,
        ),
        onCameraMove: _onCameraMove,
        indoorViewEnabled: true,
        trafficEnabled: true,
        myLocationEnabled: true,
        markers: Set.of((currentLocation != null)
            ? [
                Marker(
                  markerId: const MarkerId("selected"),
                  position: currentLocation!,
                )
              ]
            : []),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aqui você pode acessar as coordenadas latitude e longitude
          Navigator.pop(context, currentLocation);
        },
        label: const Text('Confirmar'),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    var here = await location.getLocation();

    setState(() async {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(here.latitude!, here.longitude!)),
        ),
      );
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      currentLocation = position.target;
    });
  }
}
