import 'package:front/models/geo_json.dart';

class TimeOpen {
  final String days;
  final String hours;

  TimeOpen({
    required this.days,
    required this.hours,
  });
}

class Office {
  final String id;
  final String salePointName;
  final String address;
  final bool rko;
  final bool openOffice;
  final bool hasSuo;
  final bool hasRamp;
  final String? metroStation;
  final List<TimeOpen> openHoursLegal;
  final List<TimeOpen> openHoursIndividual;
  final GeoJSON coordinates;

  Office({
    required this.id,
    required this.salePointName,
    required this.address,
    required this.rko,
    required this.openOffice,
    required this.hasSuo,
    required this.hasRamp,
    required this.metroStation,
    required this.openHoursIndividual,
    required this.openHoursLegal,
    required this.coordinates,
  });

  static Office fromJson(Map<String, dynamic> value) {
    return Office(
      id: value["_id"],
      salePointName: value["sale_point_name"],
      address: value["address"],
      rko: value["rko"],
      openOffice: value["open_office"],
      hasSuo: value["has_suo"],
      hasRamp: value["has_ramp"],
      metroStation: value["metro_station"],
      openHoursIndividual: List<TimeOpen>.from(value["open_hours_individual"]
          .map((e) => TimeOpen(days: e["days"], hours: e["hours"]))
          .toList()),
      openHoursLegal: List<TimeOpen>.from(value["open_hours_legal"]
          .map((e) => TimeOpen(days: e["days"], hours: e["hours"]))
          .toList()),
      coordinates: GeoJSON(
        type: value["coordinates"]["type"],
        coordinates: List<double>.from(value["coordinates"]["coordinates"]),
      ),
    );
  }
}
