import 'dart:convert';

import 'package:eaudit/model/pie_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class MonitoringTindakLanjutManagementLetterModel {
  final String? name; //": "Belum TL",
  final int? jumlah; //": "947",
  final Color? warna;

  MonitoringTindakLanjutManagementLetterModel({
    this.name,
    this.jumlah,
    this.warna,
  }); //": "#12a615"

  static MonitoringTindakLanjutManagementLetterModel fromJson(
      Map<String, dynamic> json) {
    return MonitoringTindakLanjutManagementLetterModel(
      name: json["name"] as String?,
      jumlah: int.parse(json["jumlah"] as String? ?? "0"),
      warna: Color(int.parse(
          (json["warna"] as String? ?? "#000000").replaceAll("#", "0xff"))),
    );
  }

  static Future<List<MonitoringTindakLanjutManagementLetterModel>> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_monitoring_tl_ml",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return (((value)["result"]) as List)
            .map((e) => MonitoringTindakLanjutManagementLetterModel.fromJson(e))
            .toList();
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static PieChartModel toPieChartData(
      List<MonitoringTindakLanjutManagementLetterModel> source) {
    PieChartModel data = PieChartModel(
      data: List.generate(source.length, (index) {
        return PieChartDataModel(
          domain: source[index].name,
          color: source[index].warna,
          total: source[index].jumlah,
        );
      }),
    );

    return data;
  }
}
