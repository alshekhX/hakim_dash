import 'package:dio/dio.dart';

class NetworkConst {
  // ignore: unnecessary_new
  final BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.43.251:9000",
    connectTimeout: 30000,
    receiveTimeout: 30000,
    contentType: 'application/json',
    validateStatus: (status) {
      return status! < 600;
    },
  );

  final String mainUrl = "http://192.168.43.251:9000";
  final String photoUrl = 'http://192.168.43.251:9000/uploads/photos/';
}
