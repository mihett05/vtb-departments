import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:front/widgets/zoom_buttons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final _mapController = MapController();

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  void loadLocation() async {
    final permission = await Geolocator.checkPermission();
    print("loadLocation");
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        _mapController.move(LatLng(position.latitude, position.longitude), 16);
      }
    }
  }

  void center() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        _mapController.move(
          LatLng(lastPosition.latitude, lastPosition.longitude),
          16,
        );
      }

      final position = await Geolocator.getCurrentPosition();
      if (lastPosition == null ||
          position.latitude.toStringAsFixed(2) !=
              lastPosition.latitude.toStringAsFixed(2) ||
          position.longitude.toStringAsFixed(2) !=
              lastPosition.longitude.toStringAsFixed(2)) {
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          16,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(55.75095437308601, 37.61761841296195),
        initialZoom: 10,
        minZoom: 4,
        maxZoom: 17,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          retinaMode: true,
        ),
        ZoomButtons(
          minZoom: 4,
          maxZoom: 17,
          mini: false,
          padding: 10,
          alignment: Alignment.bottomRight,
          onCenter: () async => center(),
        )
      ],
    );
  }
}
