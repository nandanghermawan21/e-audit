import 'package:flutter/material.dart';

class BarChartModel {
  final String? id;
  final Color? color;
  final List<BarChartDataModel>? data;

  BarChartModel({
    this.id,
    this.color,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "color": color,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class BarChartDataModel {
  final String? domain;
  final int? measure;

  BarChartDataModel({
    this.domain,
    this.measure,
  });

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'measure': measure,
    };
  }
}

String mountNameSort(int number) {
  switch (number) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "Mei";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Agu";
    case 9:
      return "Sep";
    case 10:
      return "Okt";
    case 11:
      return "Nov";
    case 12:
      return "Des";
    default:
      return "";
  }
}
