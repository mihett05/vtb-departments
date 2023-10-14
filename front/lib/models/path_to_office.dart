import 'package:flutter/material.dart';

class PathToOffice {
  String address;
  double time;
  Workload workload;
  Color? color;

  PathToOffice({
    required this.address,
    required this.time,
    required this.workload,
  }) {
    if (workload == Workload.high) {
      color = Color(0xffca181f);
    } else if (workload == Workload.medium) {
      color = Color(0xffF1A038);
    } else {
      color = Color(0xff4CC864);
    }
  }
}

enum Workload {
  high,
  medium,
  low,
}
