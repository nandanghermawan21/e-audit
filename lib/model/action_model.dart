import 'package:flutter/material.dart';

class ActionModel {
  String? label;
  String? value;
  String? description;
  Color? color;
  bool? visible;

  ActionModel({
    this.label,
    this.value,
    this.description,
    this.color,
    this.visible = false,
  });

  ActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    description = json['description'];
    color = json['color'] != null
        ? Color(int.parse((json['color'] as String).replaceAll("#", "0xff")))
        : null;
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

  static List<ActionModel> kkaAction(bool? approve, bool? prupose) {
    return [
      ActionModel(
        label: "Ajukan",
        value: "1",
        description: "Menyetujui",
        color: Colors.green,
        visible: prupose ?? false,
      ),
      ActionModel(
        label: "Setujui",
        value: "2",
        description: "Menyetujui",
        color: Colors.green,
        visible: approve ?? false,
      ),
      ActionModel(
        label: "Tolak",
        value: "3",
        description: "Menolak",
        color: Colors.red,
        visible: approve ?? false,
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
