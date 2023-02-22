import 'package:dio/dio.dart';

class NetworkConst {
  // ignore: unnecessary_new
  final BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.43.250:9000",
    connectTimeout: 300000,
    receiveTimeout: 300000,
    contentType: 'application/json',
    validateStatus: (status) {
      return status! < 600;
    },
  );

  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2UzYmNhOGIwOTJmYmNiNTAzY2ZiNjkiLCJpYXQiOjE2NzU4Njk1MzYsImV4cCI6MTcwNjk3MzUzNn0.KkhuvYQPscSQlcjCLByCEgf8gVYFOWV5GrgZoohthbM";
  final String mainUrl = "http://192.168.43.250:9000";
  final String photoUrl = 'http://192.168.43.250:9000/uploads/photos/';
}
