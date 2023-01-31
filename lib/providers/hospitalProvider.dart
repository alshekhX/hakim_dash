import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../consts/networkConst.dart';
import '../models/Doctor.dart';
import '../models/HomeCare.dart';

import '../models/Hospital.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospital>? hospitals;

  // ignore: unnecessary_new

  final options = NetworkConst().options;

  postHospital(List<File> file, String token, Hospital hospital) async {
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

    FormData formData = FormData.fromMap({
      "name": hospital.name,
      'username': hospital.phone,
      "assets": assets,
      "location": hospital.location,
      "phone": hospital.phone,
      "description": hospital.description,
    });
     try {
      Response response = await dio.post("/api/v1/homecare", data: formData);
      print(response.data);
      if (response.statusCode == 201) {
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

        print(hospitals![0].name);
        notifyListeners();
        return 'success';
      } else {
        return response.data.toString();
      }
      // } catch (e) {
      //   return e.toString();
      // }
    }
  }

