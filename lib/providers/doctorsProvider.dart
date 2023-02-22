import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hakim_dash/consts/networkConst.dart';

import '../models/Doctor.dart';

class DoctorsProvider with ChangeNotifier {
  List<Doctor>? doctors;
  final options = NetworkConst().options;
  // ignore: unnecessary_new

  getDoctor(int i) async {
    // try {
    Dio dio = Dio(options);

    Response response = await dio
        .get("/api/v1/doctor", queryParameters: {"page": i, "limit": 8});
    if (response.statusCode == 200) {
      final map = response.data['data'];

      doctors = map.map((i) => Doctor.fromJson(i)).toList().cast<Doctor>();

      notifyListeners();
      return 'success';
    } else {
      return response.data.toString();
    }
    // } catch (e) {
    //   return e.toString();
    // }
  }

  postDoc(File image, String token, Doctor doctor) async {
    final Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    String fileName = image.path.split('/').last;

    final docImage =
        await MultipartFile.fromFile(image.path, filename: fileName);

    // await file.map((e) async {
    //   String fileName = e.path.split('/').last;

    //   return await MultipartFile.fromFile(e.path, filename: fileName);
    // }).toList();
    print({
      "photo": docImage,
      "email": doctor.email,
      "phone": doctor.phone,
      "description": doctor.description,
      "category": doctor.category,
      "firstname": doctor.firstName,
      "lastname": doctor.lastName
    });

    FormData formData = FormData.fromMap({
      "photoFile": docImage,
      "email": doctor.email,
      "phone": doctor.phone,
      "description": doctor.description,
      "category": doctor.category,
      "firstname": doctor.firstName,
      "lastname": doctor.lastName,
      "rank":doctor.rank
    });

    try {
      Response response = await dio.post("/api/v1/doctor", data: formData);
      print(response.data);
      if (response.statusCode == 201) {
        getDoctor(1);
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

  deleteDoctor(String id, String token) async {
    Dio dio = Dio(options);

    try {
      dio.options.headers["authorization"] = 'Bearer $token';

      // Response response = await dio.get("/api/v1/articles", queryParameters: {
      //   'createdAt': {"$gte": "$dayBefore", "\$$lte": "$dayEnd"}
      // });

      Response response = await dio.delete(
        "/api/v1/doctor/$id",
      );

      print(response.data);
      if (response.statusCode == 200) {
        await getDoctor(1);
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






   updateDoc(File image, String token, Doctor doctor) async {
    final Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    String fileName = image.path.split('/').last;

    final docImage =
        await MultipartFile.fromFile(image.path, filename: fileName);

    // await file.map((e) async {
    //   String fileName = e.path.split('/').last;

    //   return await MultipartFile.fromFile(e.path, filename: fileName);
  

    FormData formData = FormData.fromMap({
      "photoFile": docImage,
      "email": doctor.email,
      "phone": doctor.phone,
      "description": doctor.description,
      "category": doctor.category,
      "firstname": doctor.firstName,
      "lastname": doctor.lastName,
            "rank":doctor.rank

    });

    try {
      Response response = await dio.put("/api/v1/doctor/${doctor.id}", data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        getDoctor(1);
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

  
}
