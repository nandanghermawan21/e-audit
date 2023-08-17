import 'package:eaudit/model/audit_tl_item_model.dart';
import 'package:eaudit/model/komentar_odel.dart';
import 'package:flutter/material.dart';

class AuditRekomendasiModel {
  String? deskripsi;
  String? status;
  String? statusRekomensai;
  int? sisaHariTindakLanjut;
  Color? color;
  List<AuditTLItemModel?>? listItem;
  List<KomentarModel?>? komentar;

  AuditRekomendasiModel({
    this.deskripsi,
    this.status,
    this.sisaHariTindakLanjut,
    this.color,
    this.listItem,
    this.komentar,
  });

  static AuditRekomendasiModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiModel(
      deskripsi: json["deskripsi"],
      status: json["status"],
      sisaHariTindakLanjut: json["sisa_hari_tindak_lanjut"],
      color: json["status"] != null ? Color(json["status"]) : null,
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
      "sisa_hari_tindak_lanjut": sisaHariTindakLanjut,
      "color": color?.value,
      "komentar": komentar?.map((e) => e?.toJson()).toList()
    };
  }

  //dummy
  static List<AuditRekomendasiModel> dummys() {
    return <AuditRekomendasiModel>[
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        status: "Selesai",
        color: Colors.green,
        sisaHariTindakLanjut: 10,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        status: "Belum Tindak Lanjut",
        sisaHariTindakLanjut: 10,
        color: Colors.orange,
        komentar: KomentarModel.dummy(),
        listItem: AuditTLItemModel.dummy(),
      ),
    ];
  }
}
