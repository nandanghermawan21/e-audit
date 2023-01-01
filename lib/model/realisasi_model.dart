import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class RealisasiModel {
  int? ongoing; //": "76",
  int? finding; //": "992",
  int? recomendation;

  RealisasiModel({
    this.ongoing,
    this.finding,
    this.recomendation,
  }); //": "3247"

  static RealisasiModel fromJson(Map<String, dynamic> json) {
    return RealisasiModel(
      ongoing: int.parse(json["ongoing"] as String? ?? "0"),
      finding: int.parse(json["finding"] as String? ?? "0"),
      recomendation: int.parse(json["recomendation"] as String? ?? "0"),
    );
  }

  static Future<RealisasiModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_realisasi_temuan_rekomendasi",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return RealisasiModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
