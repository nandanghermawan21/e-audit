import 'dart:convert';

import 'package:eaudit/model/bar_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class MonitoringExternalModel {
  final int? jumlahTemuan; //": 0,
  final int? jumlahRekomendasi; //": 0,
  final int? jumlahTindakLanjut;
  int? percentage;

  MonitoringExternalModel({
    this.jumlahTemuan,
    this.jumlahRekomendasi,
    this.jumlahTindakLanjut,
    this.percentage = 0,
  }) {
    if ((jumlahTindakLanjut ?? 0) != 0 && (jumlahTemuan ?? 0) != 0) {
      percentage =
          (((jumlahTindakLanjut ?? 0) / (jumlahTemuan ?? 0)) * 100).ceil();
    }
  } //": 0

  static Map<String, MonitoringExternalModel> fromJson(
      Map<String, dynamic> json) {
    Map<String, MonitoringExternalModel> data = {};

    for (var key in json.keys) {
      data[key] = MonitoringExternalModel(
        jumlahTemuan: json[key]["jumlah_temuan"] as int?,
        jumlahRekomendasi: json[key]["jumlah_rekomendasi"] as int?,
        jumlahTindakLanjut: json[key]["jumlah_tindak_lanjut"] as int?,
      );
    }

    return data;
  }

  static Future<Map<String, MonitoringExternalModel>> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_monitoring_eksternal",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return MonitoringExternalModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static List<BarChartModel> toBarChartData(
      Map<String, MonitoringExternalModel> source) {
    List<BarChartModel> data = [];

    //add id realisasi
    data.add(BarChartModel(
        id: "Temuan",
        color: Colors.blue,
        data: List.generate(source.keys.length, (i) {
          return BarChartDataModel(
            domain: source.keys.toList()[i].replaceFirst(" ", "\n"),
            measure: source[source.keys.toList()[i]]?.jumlahTemuan ?? 0,
            percentage: source[source.keys.toList()[i]]?.percentage ?? 0,
          );
        })));

    //add id realisasi
    data.add(BarChartModel(
        id: "Rekomendasi",
        color: Colors.orange,
        data: List.generate(source.keys.length, (i) {
          return BarChartDataModel(
            domain: source.keys.toList()[i].replaceFirst(" ", "\n"),
            measure: source[source.keys.toList()[i]]?.jumlahRekomendasi ?? 0,
            percentage: source[source.keys.toList()[i]]?.percentage ?? 0,
          );
        })));

    //add id realisasi
    data.add(BarChartModel(
        id: "Tindak Lanjut",
        color: Colors.green,
        data: List.generate(source.keys.length, (i) {
          return BarChartDataModel(
            domain: source.keys.toList()[i].replaceFirst(" ", "\n"),
            measure: source[source.keys.toList()[i]]?.jumlahTindakLanjut ?? 0,
            percentage: source[source.keys.toList()[i]]?.percentage ?? 0,
          );
        })));

    return data;
  }
}
