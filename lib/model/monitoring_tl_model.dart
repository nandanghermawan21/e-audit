import 'dart:convert';

import 'package:eaudit/model/pie_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class MonitoringTindakLanjutModel {
  final List<String?>? statusTl;
  final List<Color?>? warnaTl;
  final List<int?>? jumlahJl;

  MonitoringTindakLanjutModel({
    this.statusTl,
    this.warnaTl,
    this.jumlahJl,
  });

  static MonitoringTindakLanjutModel fromJson(Map<String, dynamic> json) {
    return MonitoringTindakLanjutModel(
      statusTl: (json["status_tl"] as List).map((e) => e as String?).toList(),
      warnaTl: (json["warna_tl"] as List)
          .map((e) => Color(
              int.parse((e as String? ?? "#000000").replaceAll("#", "0xff"))))
          .toList(),
      jumlahJl: (json["jumlah_tl"] as List)
          .map((e) => int.parse(e as String? ?? "0"))
          .toList(),
    );
  }

  static Future<MonitoringTindakLanjutModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_monitoring_tl",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return MonitoringTindakLanjutModel.fromJson(((value)["result"]));
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
        statusTl?.length ?? 0,
        (i) {
          return PieChartDataModel(
            domain: statusTl?[i],
            color: warnaTl![i],
            total: jumlahJl![i],
          );
        },
      ),
    );

    return data;
  }
}
