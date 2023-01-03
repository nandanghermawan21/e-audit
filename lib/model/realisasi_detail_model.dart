import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class RealisasiDetailModel {
  int? ongoing; //": "76",
  int? finding; //": "992",
  int? recomendation;

  RealisasiDetailModel({
    this.ongoing,
    this.finding,
    this.recomendation,
  }); //": "3247"

  static RealisasiDetailModel fromJson(Map<String, dynamic> json) {
    return RealisasiDetailModel(
      ongoing: int.parse(json["ongoing"] as String? ?? "0"),
      finding: int.parse(json["finding"] as String? ?? "0"),
      recomendation: int.parse(json["recomendation"] as String? ?? "0"),
    );
  }

  static Future<RealisasiDetailModel> get({
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
        return RealisasiDetailModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
