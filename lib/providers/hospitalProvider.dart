import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../consts/networkConst.dart';

import '../models/Hospital.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospital>? hospitals;

  LatLng? _hospitalatLng;

  LatLng? get hospitalatLng => _hospitalatLng;

  determinePosition(LatLng? po) {
    _hospitalatLng = po;
    notifyListeners();
  }

  // ignore: unnecessary_new

  final options = NetworkConst().options;

  postHospital(
      List<File> file, String token, Hospital hospital, LatLng position) async {
    final Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    List<MultipartFile> assets = [];

    for (int i = 0; i < file.length; i++) {
      String fileName = file[i].path.split('/').last;

      final image =
          await MultipartFile.fromFile(file[i].path, filename: fileName);

      assets.add(image);
    }

    // await file.map((e) async {
    //   String fileName = e.path.split('/').last;

    //   return await MultipartFile.fromFile(e.path, filename: fileName);
    // }).toList();
    print({
      "name": hospital.name,
      "position": {
        "type": "Point",
        "coordinates": [position.longitude, position.latitude]
      },
      "assets": assets,
      "location": hospital.location,
      "phone": hospital.phone,
      "description": hospital.description,
    });

    FormData formData = FormData.fromMap({
      "name": hospital.name,
      "position": {
        "type": "Point",
        "coordinates": [position.longitude.toDouble(), position.latitude.toDouble()],
      },
      "assets": assets,
      "location": hospital.location,
      "phone": hospital.phone,
      "description": hospital.description,
    });
    try {
      Response response = await dio.post("/api/v1/hospital", data: {
      "name": hospital.name,
      "position": {
        "type": "Point",
        "coordinates": [position.longitude.toDouble(), position.latitude.toDouble()],
      },
      // "assets": assets,
      "location": hospital.location,
      "phone": hospital.phone,
      "description": hospital.description,
    });
      print(response.data);
      if (response.statusCode == 201) {
        getHospitals(1);
        return 'success';
      } else if (response.statusCode! == 401) {
        return 'd';
      } else if (response.statusCode! >= 500) {
        return 's';
      } else {
        return response.data.toString();
      }
    } catch (e) {
      print(e);
      return 'Slow internet, Please Try again';
    }
  }

  updateHospital(List<File> file, String token, Hospital hospital) async {
    final Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    List<MultipartFile> assets = [];

    for (int i = 0; i < file.length; i++) {
      String fileName = file[i].path.split('/').last;

      final image =
          await MultipartFile.fromFile(file[i].path, filename: fileName);

      assets.add(image);
    }

    // await file.map((e) async {
    //   String fileName = e.path.split('/').last;

    //   return await MultipartFile.fromFile(e.path, filename: fileName);
    // }).toList();
    print(hospital.id);
    FormData formData = FormData.fromMap({
      //   "position": {
      //   "type": 'Point',
      //   "coordinates": [hospital.position!.coordinates[0], hospital.position!.coordinates[1],].toList()
      // },
      "name": hospital.name,
      'username': hospital.phone,
      "assets": assets,
      "location": hospital.location,
      "phone": hospital.phone,
      "description": hospital.description,
    });
    try {
      Response response =
          await dio.put("/api/v1/hospital/${hospital.id}", data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        return 'success';
      } else if (response.statusCode! == 401) {
        return 'd';
      } else if (response.statusCode! >= 500) {
        return 's';
      } else {
        return response.data.toString();
      }
    } catch (e) {
      print(e);
      return 'Slow internet, Please Try again';
    }
  }

  getHospitals(int i) async {
    // try {
    Dio dio = Dio(options);

    Response response = await dio
        .get("/api/v1/hospital", queryParameters: {"page": i, "limit": 8});
    if (response.statusCode == 200) {
      final map = response.data['data'];

      hospitals =
          map.map((i) => Hospital.fromJson(i)).toList().cast<Hospital>();

      notifyListeners();
      return 'success';
    } else {
      return response.data.toString();
    }
    // } catch (e) {
    //   return e.toString();
    // }
  }

  deleteHospital(String id, String token) async {
    Dio dio = Dio(options);

    try {
      dio.options.headers["authorization"] = 'Bearer $token';

      // Response response = await dio.get("/api/v1/articles", queryParameters: {
      //   'createdAt': {"$gte": "$dayBefore", "\$$lte": "$dayEnd"}
      // });

      Response response = await dio.delete(
        "/api/v1/hospital/$id",
      );
      if (response.statusCode == 200) {
        await getHospitals(1);
        // DateTime
        return 'success';
      } else {
        String error = response.data.toString();
        return error;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
