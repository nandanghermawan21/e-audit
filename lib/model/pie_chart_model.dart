import 'package:flutter/material.dart';

class PieChartModel {
  final List<PieChartDataModel>? data;
  int total = 0;

  PieChartModel({required this.data}) {
    calculate();
  }

  void calculate() {
    total = 0;
    for (var e in data ?? <PieChartDataModel>[]) {
      total = total + (e.total ?? 0);
    }
    for (var e in data ?? <PieChartDataModel>[]) {
      if (e.total == 0 || total == 0) {
        e.measure = 0;
      } else {
        e.measure = (e.total ?? 0) / total * 100;
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class PieChartDataModel {
  String? domain;
  double? measure;
  int? total;
  Color? color;

  PieChartDataModel({
    this.domain,
    this.measure,
    this.total,
    this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'measure': measure,
      'total': total,
    };
  }
}
