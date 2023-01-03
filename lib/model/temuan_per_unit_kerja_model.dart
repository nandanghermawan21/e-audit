import 'dart:convert';

import 'package:eaudit/model/bar_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class TemuanPerUnitKerjaModel {
  final List<String?>? jenisAuiditee;
  final List<int?>? temuan;
  final List<int?>? rekomendasi;

  TemuanPerUnitKerjaModel({
    this.jenisAuiditee,
    this.temuan,
    this.rekomendasi,
  });

  static TemuanPerUnitKerjaModel fromJson(Map<String, dynamic> json) {
    return TemuanPerUnitKerjaModel(
      jenisAuiditee:
          (json["jenis_auditee"] as List).map((e) => e as String?).toList(),
      temuan: (json["temuan"] as List)
          .map((e) => int.parse(e as String? ?? "0"))
          .toList(),
      rekomendasi: (json["rekomendasi"] as List)
          .map((e) => int.parse(e as String? ?? "0"))
          .toList(),
    );
  }

  static Future<TemuanPerUnitKerjaModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_temuan_per_jenis",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return TemuanPerUnitKerjaModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  List<BarChartModel> toBarChartData() {
    List<BarChartModel> data = [];

    data.add(
      BarChartModel(
        id: "Rekomendasi",
        color: Colors.green,
        data: List.generate(
          jenisAuiditee?.length ?? 0,
          (i) {
            return BarChartDataModel(
              domain: jenisAuiditee![i],
              measure: rekomendasi![i],
            );
          },
        ),
      ),
    );

    data.add(
      BarChartModel(
        id: "Temuan",
        color: Colors.orange,
        data: List.generate(
          jenisAuiditee?.length ?? 0,
          (i) {
            return BarChartDataModel(
              domain: jenisAuiditee![i],
              measure: temuan![i],
            );
          },
        ),
      ),
    );

    return data;
  }
}
