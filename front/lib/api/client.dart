import 'dart:math';

import 'package:dio/dio.dart';
import 'package:front/models/geo_json.dart';
import 'package:front/models/office.dart';
import 'package:front/models/path_to_office.dart';
import 'package:latlong2/latlong.dart';

final dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.17:8000'));

Future<List<Office>> getDepartments() async {
  final result = await dio.get('/static/');
  return List<Office>.from(
      result.data["offices"].map((office) => Office.fromJson(office)).toList());
}

Future<List<PathToOffice>> getOffices(LatLng location, bool hasRamp) async {
  final result = await dio.post('/paths/get_offices', data: {
    "has_ramp": hasRamp,
    "profile": "driving-car",
    "geo_json": {
      "type": "Point",
      "coordinates": [location.longitude, location.latitude],
    }
  });
  final data = result.data;

  List<PathToOffice> paths = [];

  for (var i = 0; i < data["offices"].length; i++) {
    final office = data["offices"][i];
    final pathData = data["paths"][i];
    final load = double.parse(data["arrival_load"][i].toString());
    final path =
        List<List<double>>.from(pathData[1].map((e) => List<double>.from(e)))
            .map((e) => LatLng(e[1], e[0]))
            .toList();
    final time = pathData[2]["duration"];
    final address =
        office["address"].split(",").sublist(2).map((e) => e.trim()).join(", ");

    paths.add(
      PathToOffice(
        load,
        address: address.substring(0, min<int>(address.length, 26)),
        time: double.parse(((time / 60) as double).toStringAsFixed(1)),
        path: path,
      ),
    );
  }
  return paths;
}
