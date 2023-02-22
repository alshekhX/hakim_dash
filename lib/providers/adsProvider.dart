import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../consts/networkConst.dart';
import '../models/Ad.dart';

class AdsProvider with ChangeNotifier {
  List<Ad>? ads;

  final options = NetworkConst().options;

  getAds(int i) async {
    try {
      Dio dio = Dio(options);

      Response response =
          await dio.get("/api/v1/ad", queryParameters: {"page": i, "limit": 3});
      if (response.statusCode == 200) {
        final map = response.data['data'];

        ads = map.map((i) => Ad.fromMap(i)).toList().cast<Ad>();
        print(ads![0].assets);

        notifyListeners();
        return 'success';
      } else {
        print(response.data.toString());
        return response.data.toString();
      }
    } catch (e) {
      print(e);

      return e.toString();
    }
  }

  
  postAD( file, String token, Ad ad) async {
    final Dio dio = Dio(options);
    dio.options.headers["authorization"] = 'Bearer $token';

    List<MultipartFile> assets = [];

      String fileName = file.path.split('/').last;

      final image =
          await MultipartFile.fromFile(file.path, filename: fileName);

      assets.add(image);
    

    // await file.map((e) async {
    //   String fileName = e.path.split('/').last;

    //   return await MultipartFile.fromFile(e.path, filename: fileName);
    // }).toList();

    FormData formData = FormData.fromMap({
      "title": ad.title,
      'description': ad.description,
      "assets": assets,
      "duration": ad.duration,
      "type": ad.type,
    });

    try {
      Response response = await dio.post("/api/v1/ad", data: formData);
      print(response.data);
      if (response.statusCode == 201) {
        getAds(1);
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


  // searchHospitals(int i, String name) async {
  //   try {
  //     Dio dio = Dio(options);
  //  var regex = "regex";
  //     var optionss = "options";
  //     Response response = await dio
  //         .get("/api/v1/hospital", queryParameters: {"page": i, "limit": 8,
  //          'name': {'\$$regex': name, "\$$optionss": 'i'}});
  //     if (response.statusCode == 200) {
  //       final map = response.data['data'];

  //       searchedHospitals =
  //           map.map((i) => Hospital.fromJson(i)).toList().cast<Hospital>();

  //       notifyListeners();
  //       return 'success';
  //     } else {
  //       print(response.data.toString());
  //       return response.data.toString();
  //     }
  //   } catch (e) {
  //             print(e);

  //     return e.toString();
  //   }
  // }

//   getNearHospitals() async {
//     try {
//       Dio dio = Dio(options);

//       Response response = await dio
//           .get("/api/v1/hospital/near");
//       if (response.statusCode == 200) {
//         final map = response.data['data'];

//         hospitals =
//             map.map((i) => Hospital.fromJson(i)).toList().cast<Hospital>();

//         notifyListeners();
//         return 'success';
//       } else {
//         print(response.data.toString());
//         return response.data.toString();
//       }
//     } catch (e) {
//               print(e);

//       return e.toString();
//     }
//   }
// }

}
