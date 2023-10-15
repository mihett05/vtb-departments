import 'package:dio/dio.dart';
import 'package:front/models/geo_json.dart';
import 'package:front/models/office.dart';

final dio = Dio(BaseOptions(baseUrl: 'http://172.17.0.1:8000'));

Future<List<Office>> getDepartments() async {
  final result = await dio.get('/static/');
  return List<Office>.from(
      result.data["offices"].map((office) => Office.fromJson(office)).toList());
}
