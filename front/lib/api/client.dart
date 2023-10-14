import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

final dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.17:8080'));

void getDepartments() async {
  final result = await dio.get('/static/');
}
