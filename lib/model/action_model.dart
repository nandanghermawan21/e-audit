import 'package:flutter/material.dart';

class ActionModel {
  String? label;
  String? value;
  String? description;
  Color? color;

  ActionModel({
    this.label,
    this.value,
    this.description,
    this.color,
  });

  ActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    description = json['description'];
    color = json['color'] != null ? Color(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'description': description,
      'color': color?.value,
    };
  }

  static List<ActionModel> dummy() {
    return [
      ActionModel(
        label: "Setujui",
        value: "Disetujui",
        description: "Menyetujui",
        color: Colors.green,
      ),
      ActionModel(
        label: "Tolak",
        value: "Ditolak",
        description: "Menolak",
        color: Colors.red,
      ),
    ];
  }

  static List<ActionModel> kkptDisetujui() {
    return [
      ActionModel(
        label: "Masuk LHA",
        value: "Masuk LHA",
        description: "Masukan Ke LHA",
        color: Colors.green,
      ),
    ];
  }
}
