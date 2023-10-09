import 'dart:convert';

import 'package:eaudit/model/audit_rekomendasi_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditTLModel {
  String? id;
  String? noTemuan;
  String? uraianTemuan;
  String? rekomendasi;
  List<AuditRekomendasiModel?>? listRekomendasi;
  String? judulTemuan;

  AuditTLModel({
    this.id,
    this.noTemuan,
    this.judulTemuan,
    this.uraianTemuan,
    this.rekomendasi,
    this.listRekomendasi,
  });

  Map<String, dynamic> toJson() {
    return {
      "no_temuan": noTemuan,
      "judul_temuan": judulTemuan,
      "uraian_temuan": uraianTemuan,
      "rekomendasi": rekomendasi,
      "rekomendasi_list": listRekomendasi?.map((e) => e?.toJson()).toList(),
    };
  }

  static AuditTLModel fromJson(Map<String, dynamic> json) {
    return AuditTLModel(
      id: json["finding_id"],
      noTemuan: json["finding_no"],
      judulTemuan: json["finding_judul"],
      uraianTemuan: json["finding_uraian"],
      rekomendasi: (json["rekomendasi"]),
      listRekomendasi: json["rekomendasi_list"] != null
          ? List<AuditRekomendasiModel>.from(
              (json["rekomendasi_list"] as List)
                  .map((x) => AuditRekomendasiModel.fromJson(x)),
            )
          : null,
    );
  }

  static Future<List<AuditTLModel>> get({
    required String? token,
    required String? assignId,
    required String? searchKey,
    required String? status,
    required String? type,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "$type",
        "assign_id": "$assignId",
        "search_key": "$searchKey",
        "status": status ?? "",
        "token": "$token",
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] != "" && (value)["message"] != null) {
        throw BasicResponse(message: (value)["message"]);
      }
      return (value["finding"] as List)
          .map((e) => AuditTLModel.fromJson(e))
          .toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //dummy
  static List<AuditTLModel> dummys() {
    return <AuditTLModel>[
      AuditTLModel(
        noTemuan: "41341234",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Serang",
        rekomendasi: "4/LHA/II/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        noTemuan: "723452345",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Batam",
        rekomendasi: "4/LHA/I3/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        noTemuan: "9456334566",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Sorong",
        rekomendasi: "14/LHA/I9/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
    ];
  }
}
