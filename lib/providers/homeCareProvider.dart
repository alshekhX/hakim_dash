import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../consts/networkConst.dart';
import '../models/HomeCare.dart';

class HomeCareProvider with ChangeNotifier {
  List<HomeCare>? homeCares;
  final options = NetworkConst().options;

  deleteHomeCare(String id, String token) async {
    Dio dio = Dio(options);

    try {
      dio.options.headers["authorization"] = 'Bearer $token';

      // Response response = await dio.get("/api/v1/articles", queryParameters: {
      //   'createdAt': {"$gte": "$dayBefore", "\$$lte": "$dayEnd"}
      // });

      Response response = await dio.delete(
        "/api/v1/homecare/$id",
      );
      if (response.statusCode == 200) {
        await getHomeCare(1);
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

  updateHomeCare(List<File> file, String token, HomeCare homeCare) async {
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
    print(homeCare.id);
    FormData formData = FormData.fromMap({
      "name": homeCare.name,
      'username': homeCare.phone,
      "assets": assets,
      // "position":  { "type": "Point", "coordinates": [longitude, latitude] }
      
      "location": homeCare.location,
      "phone": homeCare.phone,
      "description": homeCare.description,
    });
    try {
      Response response =
          await dio.put("/api/v1/homecare/${homeCare.id}", data: formData);
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

  getHomeCare(int i) async {
    try {
      Dio dio = Dio(options);

      Response response = await dio
          .get("/api/v1/homecare", queryParameters: {"page": i, "limit": 8});
      if (response.statusCode == 200) {
        final map = response.data['data'];

        homeCares =
            map.map((i) => HomeCare.fromJson(i)).toList().cast<HomeCare>();

        print(homeCares![0].name);
        notifyListeners();
        return 'success';
      } else {
        return response.data.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  postHomeCare(List<File> file, String token, HomeCare homeCare) async {
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
      "name": homeCare.name,
      'username': homeCare.phone,
      "assets": assets,
      "location": homeCare.location,
      "phone": homeCare.phone,
      "description": homeCare.description,
    });

    try {
      Response response = await dio.post("/api/v1/homecare", data: formData);
      print(response.data);
      if (response.statusCode == 201) {
        getHomeCare(1);
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
