import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class PathToOffice {
  String address;
  double time;
  Workload workload = Workload.off;
  Color? color;
  List<LatLng> path;

  PathToOffice(double load, {
    required this.address,
    required this.time,
    required this.path,
  }) {
    if (load == -1) {
      workload = Workload.off;
    } else if (load <= 0.3) {
      workload = Workload.low;
    } else if (load <= 0.6) {
      workload = Workload.medium;
    } else {
      workload = Workload.high;
    }

    if (workload == Workload.high) {
      color = const Color(0xffca181f);
    } else if (workload == Workload.medium) {
      color = const Color(0xffF1A038);
    } else if (workload == Workload.low) {
      color = const Color(0xff4CC864);
    } else {
      color = Colors.grey;
    }
  }
}

enum Workload {
  high,
  medium,
  low,
  off,
}
