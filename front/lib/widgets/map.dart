import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:front/widgets/office_info.dart';
import 'package:front/widgets/zoom_buttons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/office.dart';
import './search.dart';

class Map extends StatefulWidget {
  final List<Office> offices;
  final bool search;
  final List<LatLng>? path;

  const Map({super.key, required this.offices, this.search = false, this.path});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final _mapController = MapController();

  LatLng location = LatLng(55.75095437308601, 37.61761841296195);

  @override
  void initState() {
    super.initState();
    loadLocation();
    // StreamSubscription<Position> locationStream = Geolocator.getPositionStream(
    //     locationSettings: const LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10,
    // )).listen((event) {
    //   setState(() {
    //     location = LatLng(event.latitude, event.longitude);
    //   });
    // });
  }

  void loadLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        _mapController.move(LatLng(position.latitude, position.longitude), 16);
        setState(() {
          location = LatLng(position.latitude, position.longitude);
        });
      }
    }
  }

  Future<LatLng?> getLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
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
        setState(() {
          location = LatLng(position.latitude, position.longitude);
        });
      }
    }
  }

  void openBottomDrawer(Office office) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: OfficeInfo(office: office),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: location,
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
          PolylineLayer(polylines: [
            Polyline(
              points: widget.path ?? [],
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 10,
            ),
          ]),
          MarkerLayer(
            markers: widget.offices
                .map(
                  (e) => Marker(
                    point: LatLng(
                      e.coordinates.coordinates[1],
                      e.coordinates.coordinates[0],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        openBottomDrawer(e);
                      },
                      child: const Image(
                        image: AssetImage(
                          "assets/icons/office.png",
                        ),
                      ),
                    ),
                    width: 80,
                    height: 80,
                  ),
                )
                .toList(),
          ),
          CurrentLocationLayer(),
          ZoomButtons(
            minZoom: 4,
            maxZoom: 17,
            mini: false,
            padding: 10,
            alignment: Alignment.bottomRight,
            onCenter: () async => center(),
          ),
        ],
      ),
      if (widget.search) ...[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Search(
            offices: widget.offices,
            onSelected: (office) {
              _mapController.move(
                  LatLng(office.coordinates.coordinates[1],
                      office.coordinates.coordinates[0]),
                  16);
              openBottomDrawer(office);
            },
          ),
        ),
      ],
    ]);
  }
}
