import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class RealisasiModel {
  final int? rencana; //": "77",
  final int? realisasi;

  double get percentage {
    if ((rencana ?? 0) != 0 || (realisasi ?? 0) != 0) {
      return (realisasi ?? 0) / (rencana ?? 0) * 100;
    } else {
      return 0;
    }
  }

  RealisasiModel({
    this.rencana,
    this.realisasi,
  }); //": "77"

  static RealisasiModel fromJson(Map<String, dynamic> json) {
    return RealisasiModel(
      realisasi: int.parse((json["realisasi"] as String?) ?? "0"),
      rencana: int.parse((json["rencana"] as String?) ?? "0"),
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
        "method": "data_realisasi",
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
