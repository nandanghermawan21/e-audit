import 'package:eaudit/model/audit_tl_item_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:flutter/material.dart';

class AuditRekomendasiModel {
  String? deskripsi;
  String? statusRekomendasi;
  String? statusTindakLanjut;
  Color? statusRekomendasiColor;
  Color? statusTindakLanjutColor;
  String? sisaHariTindakLanjut;
  List<AuditTLItemModel?>? listItem;
  List<KomentarModel?>? komentar;

  AuditRekomendasiModel({
    this.deskripsi,
    this.statusRekomendasi,
    this.statusTindakLanjut,
    this.statusTindakLanjutColor,
    this.sisaHariTindakLanjut,
    this.statusRekomendasiColor,
    this.listItem,
    this.komentar,
  });

  static AuditRekomendasiModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiModel(
      deskripsi: json["deskripsi"],
      statusRekomendasi: json["status_rekomendasi"],
      statusTindakLanjut: json["status_tindak_lanjut"],
      statusTindakLanjutColor: json["status_tindak_lanjut_color"] != null
          ? Color(json["status_tindak_lanjut_color"])
          : null,
      sisaHariTindakLanjut: json["sisa_hari_tindak_lanjut"],
      statusRekomendasiColor: json["status_rekomendasi_color"] != null
          ? Color(json["color"])
          : null,
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
      "status_rekomendasi": statusRekomendasi,
      "status_tindak_lanjut": statusTindakLanjut,
      "status_tindak_lanjut_color": statusTindakLanjutColor?.value,
      "sisa_hari_tindak_lanjut": sisaHariTindakLanjut,
      "status_rekomeendasi_color": statusRekomendasiColor?.value,
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
        statusRekomendasi: "Selesai",
        statusTindakLanjut: "Belum Tindak Lanjut",
        statusTindakLanjutColor: Colors.red,
        statusRekomendasiColor: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        statusRekomendasi: "Belum Tindak Lanjut",
        statusTindakLanjut: "Dalam Proses Reviu Auditor",
        statusTindakLanjutColor: Colors.blue,
        sisaHariTindakLanjut: "10",
        statusRekomendasiColor: Colors.orange,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        statusRekomendasi: "Selesai",
        statusTindakLanjut: "Dalam Proses Reviu Manager",
        statusTindakLanjutColor: Colors.orange,
        statusRekomendasiColor: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        statusRekomendasi: "Belum Tindak Lanjut",
        statusTindakLanjut: "Disetujui Manager Reviu Staff QA",
        statusTindakLanjutColor: Colors.purple,
        sisaHariTindakLanjut: "10",
        statusRekomendasiColor: Colors.orange,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        statusRekomendasi: "Selesai",
        statusTindakLanjut: "Disetujui Staff QA Reviu Kabag QA",
        statusTindakLanjutColor: Colors.green,
        statusRekomendasiColor: Colors.green,
        sisaHariTindakLanjut: "10",
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
    ];
  }
}
