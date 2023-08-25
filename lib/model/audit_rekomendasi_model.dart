import 'package:eaudit/model/audit_tl_item_model.dart';
import 'package:eaudit/model/komentar_odel.dart';
import 'package:flutter/material.dart';

class AuditRekomendasiModel {
  String? deskripsi;
  String? status;
  String? statusRekomensai;
  Color? color;
  Color? statusRekomendasiColor;
  String? sisaHariTindakLanjut;
  List<AuditTLItemModel?>? listItem;
  List<KomentarModel?>? komentar;

  AuditRekomendasiModel({
    this.deskripsi,
    this.status,
    this.statusRekomensai,
    this.statusRekomendasiColor,
    this.sisaHariTindakLanjut,
    this.color,
    this.listItem,
    this.komentar,
  });

  static AuditRekomendasiModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiModel(
      deskripsi: json["deskripsi"],
      status: json["status"],
      statusRekomensai: json["status_rekomendasi"],
      statusRekomendasiColor: json["status_rekomendasi_color"] != null
          ? Color(json["status_rekomendasi_color"])
          : null,
      sisaHariTindakLanjut: json["sisa_hari_tindak_lanjut"],
      color: json["color"] != null ? Color(json["color"]) : null,
      listItem: json["list_item"] != null
          ? (json["list_item"] as List)
              .map((e) => AuditTLItemModel.fromJson(e))
              .toList()
          : null,
      komentar: json["komentar"] != null
          ? (json["komentar"] as List)
              .map((e) => KomentarModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "deskripsi": deskripsi,
      "status": status,
      "status_rekomendasi": statusRekomensai,
      "status_rekomendasi_color": statusRekomendasiColor?.value,
      "sisa_hari_tindak_lanjut": sisaHariTindakLanjut,
      "color": color?.value,
      "komentar": komentar?.map((e) => e?.toJson()).toList(),
      "list_item": listItem?.map((e) => e?.toJson()).toList(),
    };
  }

  //dummy
  static List<AuditRekomendasiModel> dummys() {
    return <AuditRekomendasiModel>[
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        status: "Selesai",
        statusRekomensai: "Belum Tindak Lanjut",
        statusRekomendasiColor: Colors.red,
        color: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        status: "Belum Tindak Lanjut",
        statusRekomensai: "Dalam Proses Reviu Auditor",
        statusRekomendasiColor: Colors.blue,
        sisaHariTindakLanjut: "10",
        color: Colors.orange,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        status: "Selesai",
        statusRekomensai: "Dalam Proses Reviu Manager",
        statusRekomendasiColor: Colors.orange,
        color: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        status: "Belum Tindak Lanjut",
        statusRekomensai: "Disetujui Manager Reviu Staff QA",
        statusRekomendasiColor: Colors.purple,
        sisaHariTindakLanjut: "10",
        color: Colors.orange,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        status: "Selesai",
        statusRekomensai: "Disetujui Staff QA Reviu Kabag QA",
        statusRekomendasiColor: Colors.green,
        color: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
    ];
  }
}
