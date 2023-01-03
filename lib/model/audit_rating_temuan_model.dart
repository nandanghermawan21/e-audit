import 'dart:convert';

import 'package:eaudit/model/pie_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class AuditRatingTemuanModel {
  final List<String?>? klasifikasi;
  final List<Color?>? warna;
  final List<int?>? jumlah;

  AuditRatingTemuanModel({
    this.klasifikasi,
    this.warna,
    this.jumlah,
  });

  static AuditRatingTemuanModel fromJson(Map<String, dynamic> json) {
    return AuditRatingTemuanModel(
      klasifikasi:
          (json["klasifikasi"] as List).map((e) => e as String?).toList(),
      warna: (json["warna"] as List)
          .map((e) => Color(
              int.parse((e as String? ?? "#000000").replaceAll("#", "0xff"))))
          .toList(),
      jumlah: (json["jumlah"] as List)
          .map((e) => int.parse(e as String? ?? "0"))
          .toList(),
    );
  }

  static Future<AuditRatingTemuanModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_rating_temuan",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return AuditRatingTemuanModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  PieChartModel toPieChartData() {
    PieChartModel data = PieChartModel(
      data: List.generate(
        klasifikasi?.length ?? 0,
        (i) {
          return PieChartDataModel(
            domain: klasifikasi?[i],
            color: warna![i],
            total: jumlah![i],
          );
        },
      ),
    );

    return data;
  }
}
