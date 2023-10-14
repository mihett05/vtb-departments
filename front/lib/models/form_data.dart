class FormData {
  ClientEntity clientEntity;
  List<String> individualServices;
  List<String> legalServices;
  bool lowMobility;
  bool privilege;
  DateTime time;

  FormData({
    required this.clientEntity,
    required this.individualServices,
    required this.legalServices,
    required this.lowMobility,
    required this.privilege,
    required this.time,
  });
}

enum ClientEntity {
  individual,
  legal,
}
