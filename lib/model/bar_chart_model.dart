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

  double get maxMeasure {
    double max = 0;
    for (var e in data ?? <BarChartDataModel>[]) {
      if ((e.measure?.toDouble() ?? 0) > max) {
        max = e.measure?.toDouble() ?? 0;
      }
    }
    return max;
  }

  static int maxMeasureFromList(List<BarChartModel>? soirce) {
    double max = 0;
    for (var e in soirce ?? <BarChartModel>[]) {
      if ((e.maxMeasure.toDouble()) > max) {
        max = e.maxMeasure.toDouble();
      }
    }
    return max.round();
  }
}

class BarChartDataModel {
  final String? domain;
  final int? measure;
  final int? percentage;

  BarChartDataModel({
    this.domain,
    this.measure,
    this.percentage,
  });

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'measure': measure,
      'percentage': percentage,
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
