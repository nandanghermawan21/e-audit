import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class JumlahReviuModel {
  int? jumlahPKA;
  int? jumlahKKA;
  int? jumlahKKPT;
  int? jumlahTL;

  JumlahReviuModel({
    this.jumlahPKA,
    this.jumlahKKA,
    this.jumlahKKPT,
    this.jumlahTL,
  });

  factory JumlahReviuModel.fromJson(Map<String, dynamic> json) {
    return JumlahReviuModel(
      jumlahPKA: json['reviu_pka'],
      jumlahKKA: json['reviu_kka'],
      jumlahKKPT: json['reviu_kkpt'],
      jumlahTL: json['reviu_tl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviu_pka': jumlahPKA,
      'reviu_kka': jumlahKKA,
      'reviu_kkpt': jumlahKKPT,
      'reviu_tl': jumlahTL,
    };
  }

  static List<JumlahReviuModel> dummy() {
    return [
      JumlahReviuModel(
        jumlahPKA: 3,
        jumlahKKA: 2,
        jumlahKKPT: 2,
        jumlahTL: 2,
      ),
    ];
  }

  static Future<JumlahReviuModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_jumlah_reviu",
        "tahun": "$tahun",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return JumlahReviuModel.fromJson(value);
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}


///248a9377857d5df32e307163067b366c9284f229
//248a9377857d5df32e307163067b366c9284f229
//9b44ac8966798da6f357fc1689342e187013cd51