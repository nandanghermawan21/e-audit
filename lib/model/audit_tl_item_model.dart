import 'dart:convert';

import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditTLItemModel {
  String? id;
  String? typeAudit;
  String? judulKegiatan;
  String? tindakLanjut;
  DateTime? tanggal;
  String? status;
  List<AuditFileModel?>? lampiran;
  List<KomentarModel?>? komentar;
  List<ActionModel?>? action;

  AuditTLItemModel({
    this.id,
    this.typeAudit,
    this.judulKegiatan,
    this.tindakLanjut,
    this.tanggal,
    this.status,
    this.lampiran,
    this.komentar,
    this.action,
  });

  factory AuditTLItemModel.fromJson(Map<String, dynamic> json) {
    return AuditTLItemModel(
      id: json['tl_id'],
      typeAudit: json['audit_type_name'],
      judulKegiatan: json['assign_kegiatan'],
      tindakLanjut: json['tl_desc'],
      tanggal: json['tl_date'] != null ? DateTime.parse(json['tl_date']) : null,
      status: json['tl_status'],
      lampiran: json['tindaklanjut_lampiran'] != null
          ? (json['tindaklanjut_lampiran'] as List?)
              ?.map((e) => AuditFileModel.fromJson(e))
              .toList()
          : null,
      komentar: json['tindaklanjut_komentar'] != null
          ? (json['tindaklanjut_komentar'] as List?)
              ?.map((e) => KomentarModel.fromJson(
                    e,
                    tanggalKey: "tl_comment_date",
                    nameKey: "auditor_name",
                    komentarKey: "tl_comment_desc",
                  ))
              .toList()
          : null,
      // action: ActionModel.dummy(),
      action: json['action'] != null
          ? (json['action'] as List?)
              ?.map((e) => ActionModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_audit': typeAudit,
      'judul_kegiatan': judulKegiatan,
      'tindak_lanjut': tindakLanjut,
      'tanggal': tanggal?.millisecondsSinceEpoch,
      'status': status,
      "lampiran": lampiran?.map((e) => e?.toJson()).toList(),
      "komentar": komentar?.map((e) => e?.toJson()).toList(),
      "action": action?.map((e) => e?.toJson()).toList(),
    };
  }

  static Future<void> postReviu({
    required String? token,
    required String? tlId,
    required String? status,
    required String? note,
    required String? type,
  }) {
    return Network.post(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "$type",
        "token": "$token",
      },
      body: {
        "tl_id": "$tlId",
        "status": "$status",
        "note": "$note"
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      try {
        value = json.decode(value);
        if ((value)["message"] == "" || (value)["message"] == null) {
          if (value == "success") {
            return;
          } else {
            throw value;
          }
        }
        throw BasicResponse(message: (value)["message"]);
      } catch (e) {
        if (value == "success") {
          return;
        } else {
          throw value;
        }
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //dummy
  static List<AuditTLItemModel> dummy() {
    return [
      AuditTLItemModel(
        tindakLanjut: "Tindak Lanjut 1",
        tanggal: DateTime.now(),
        status: "Disetujui Staff QA Review kabag QA",
        lampiran: AuditFileModel.dummy(),
        komentar: KomentarModel.dummy(),
        action: ActionModel.dummy(),
      ),
      // AuditTLItemModel(
      //   tindakLanjut: "Tindak Lanjut 2",
      //   tanggal: DateTime.now(),
      //   status: "Disetujui Staff QA Review kabag QA",
      //   lampiran: AuditFileModel.dummy(),
      //   komentar: KomentarModel.dummy(),
      //   action: ActionModel.dummy(),
      // ),
      // AuditTLItemModel(
      //   tindakLanjut: "Tindak Lanjut 3",
      //   tanggal: DateTime.now(),
      //   status: "Disetujui Staff QA Review kabag QA",
      //   lampiran: AuditFileModel.dummy(),
      //   komentar: KomentarModel.dummy(),
      //   action: ActionModel.dummy(),
      // ),
    ];
  }
}
