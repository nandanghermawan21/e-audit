import 'dart:convert';

import 'package:eaudit/model/bar_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class RealisasiBulananModel {
  final List<int>? rencana;
  final List<int>? realisasi;

  RealisasiBulananModel({
    this.rencana,
    this.realisasi,
  });

  static RealisasiBulananModel fromJson(Map<String, dynamic> json) {
    return RealisasiBulananModel(
      rencana: (json["rencana"] as List).map((e) => (e as int)).toList(),
      realisasi: (json["realisasi"] as List).map((e) => (e as int)).toList(),
    );
  }

  static Future<RealisasiBulananModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_realisasi_per_bulan",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return RealisasiBulananModel.fromJson(((value)["result"]));
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
        id: "Realisasi",
        color: Colors.green,
        data: List.generate(
          12,
          (i) {
            return BarChartDataModel(
              domain: mountNameSort(i + 1),
              measure: realisasi![i],
            );
          },
        ),
      ),
    );

    data.add(
      BarChartModel(
        id: "Rencana",
        color: Colors.orange,
        data: List.generate(
          12,
          (i) {
            return BarChartDataModel(
              domain: mountNameSort(i + 1),
              measure: rencana![i],
            );
          },
        ),
      ),
    );

    return data;
  }
}
