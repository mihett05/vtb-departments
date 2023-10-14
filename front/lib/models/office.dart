class TimeOpen {
  final String days;
  final String hours;

  TimeOpen({
    required this.days,
    required this.hours,
  });
}

class GeoJSON {
  final String type;
  final List<double> coordinates;

  GeoJSON({
    required this.type,
    required this.coordinates,
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

  Office fromJson(Map<String, dynamic> value) {
    return Office(
      id: value["_id"],
      salePointName: value["sale_point_name"],
      address: value["address"],
      rko: value["rko"],
      openOffice: value["open_office"],
      hasSuo: value["has_suo"],
      hasRamp: value["has_ramp"],
      metroStation: value["metro_station"],
      openHoursIndividual: value["open_hours_individual"]
          .map((e) => TimeOpen(days: e["days"], hours: e["hours"])),
      openHoursLegal: value["open_hours_legal"]
          .map((e) => TimeOpen(days: e["days"], hours: e["hours"])),
      coordinates: GeoJSON(
        type: value["coordinates"]["type"],
        coordinates: value["coordinates"]["coordinates"],
      ),
    );
  }
}
