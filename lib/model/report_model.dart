import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class ReportModel {
  final String? assignId; //": "fc8878fd7533e34674409c3899fd81de1f1a4558",
  final String? auditee; //": "Divisi Bisnis II",
  final String? lhaNomor; //": null,
  final String? jenisAuditee; //": "Divisi",
  final String? linkLha; //": null,
  final String? linkLhaEksternal; //": null,
  final String? linkMl;

  ReportModel({
    this.assignId,
    this.auditee,
    this.lhaNomor,
    this.jenisAuditee,
    this.linkLha,
    this.linkLhaEksternal,
    this.linkMl,
  }); //": null

  static ReportModel fromJson(Map<String, dynamic> json) {
    return ReportModel(
      assignId: json["assign_id"] as String?,
      auditee: json["auditee"] as String?,
      lhaNomor: json["lha_nomor"] as String?,
      jenisAuditee: json["jenis_auditee"] as String?,
      linkLha: json["link_lha"] as String?,
      linkLhaEksternal: json["link_lha_eksternal"] as String?,
      linkMl: json["link_ml"] as String?,
    );
  }

  static Future<List<ReportModel>> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_report",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return (((value)["result"]["data_pelaksanaan"] as List)
            .map((e) => ReportModel.fromJson(e))).toList();
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
