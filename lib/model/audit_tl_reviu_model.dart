import 'dart:convert';

import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/util/basic_response.dart';

import '../util/network.dart';
import '../util/system.dart';

class AuditTLReviuModel {
  String? id;
  String? obyekAudit;
  String? nomorLha;
  List<AuditTLModel?>? listAuditTL;

  AuditTLReviuModel({
    this.id,
    this.obyekAudit,
    this.nomorLha,
    this.listAuditTL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "obyek_audit": obyekAudit,
      "nomor_lha": nomorLha,
      "listAuditTL": listAuditTL?.map((e) => e?.toJson()).toList(),
    };
  }

  static AuditTLReviuModel fromJson(Map<String, dynamic> json) {
    return AuditTLReviuModel(
      id: json["assign_id"],
      obyekAudit: json["auditee_name"],
      nomorLha: json["nomor_lha"],
      listAuditTL: json["listAuditTL"] != null
          ? List<AuditTLModel>.from(
              json["listAuditTL"].map((x) => AuditTLModel.fromJson(x)),
            )
          : null,
    );
  }

  static Future<List<AuditTLReviuModel>> get({
    required String? token,
    required int? tahun,
    required String? searchKey,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_tl",
        "tahun": "$tahun",
        "token": "$token",
        "search": "$searchKey",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if (value == false) {
        throw BasicResponse(message: "Data gagal ditemukan");
      }
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value as List).map((e) => AuditTLReviuModel.fromJson(e)).toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //dummy
  static List<AuditTLReviuModel> dummys() {
    return <AuditTLReviuModel>[
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Serang",
        nomorLha: "4/LHA/II/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Batam",
        nomorLha: "4/LHA/I3/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Sorong",
        nomorLha: "14/LHA/I9/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
    ];
  }
}
