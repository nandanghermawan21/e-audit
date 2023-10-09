import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_model.dart';

class AuditTLItemModel {
  String? id;
  String? tindakLanjut;
  DateTime? tanggal;
  String? status;
  List<AuditFileModel?>? lampiran;
  List<KomentarModel?>? komentar;
  List<ActionModel?>? action;

  AuditTLItemModel({
    this.id,
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
      tindakLanjut: json['tl_desc'], 
      tanggal: json['tl_date'] != null
          ? DateTime.parse(json['tl_date'])
          : null,
      status: json['tl_status'],
      lampiran: json['lampiran'] != null
          ? (json['lampiran'] as List?)
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
      action: ActionModel.dummy(),
      // action: json['action'] != null
      //     ? (json['action'] as List?)
      //         ?.map((e) => ActionModel.fromJson(e))
      //         .toList()
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tindak_lanjut': tindakLanjut,
      'tanggal': tanggal?.millisecondsSinceEpoch,
      'status': status,
      "lampiran": lampiran?.map((e) => e?.toJson()).toList(),
      "komentar": komentar?.map((e) => e?.toJson()).toList(),
      "action": action?.map((e) => e?.toJson()).toList(),
    };
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
