import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_odel.dart';

class AuditTLItemModel {
  String? tindakLanjut;
  DateTime? tanggal;
  String? status;
  List<AuditFileModel?>? lampiran;
  List<KomentarModel?>? komentar;
  List<ActionModel?>? action;

  AuditTLItemModel({
    this.tindakLanjut,
    this.tanggal,
    this.status,
    this.lampiran,
    this.komentar,
    this.action,
  });

  factory AuditTLItemModel.fromJson(Map<String, dynamic> json) {
    return AuditTLItemModel(
      tindakLanjut: json['tindak_lanjut'],
      tanggal: json['tanggal'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['tanggal'])
          : null,
      status: json['status'],
      lampiran: json['lampiran'] != null
          ? (json['lampiran'] as List?)
              ?.map((e) => AuditFileModel.fromJson(e))
              .toList()
          : null,
      komentar: json['komentar'] != null
          ? (json['komentar'] as List?)
              ?.map((e) => KomentarModel.fromJson(e))
              .toList()
          : null,
      action: json['action'] != null
          ? (json['action'] as List?)
              ?.map((e) => ActionModel.fromJson(e))
              .toList()
          : null,
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
