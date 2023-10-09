import 'package:eaudit/model/audit_tl_item_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:flutter/material.dart';

class AuditRekomendasiModel {
  String? id;
  String? deskripsi;
  String? statusRekomendasi;
  String? statusTindakLanjut;
  Color? statusRekomendasiColor;
  Color? statusTindakLanjutColor;
  String? sisaHariTindakLanjut;
  List<AuditTLItemModel?>? listItem;
  List<KomentarModel?>? komentar;

  AuditRekomendasiModel({
    this.id,
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
      id: json["rekomendasi_id"],
      deskripsi: json["rekomendasi_desc"],
      statusRekomendasi: json["rekomendasi_status"],
      statusTindakLanjut: json["tindaklanjut_status"],
      statusTindakLanjutColor: json["tindaklanjut_status_color"] != null
          ? Color(int.parse((json["tindaklanjut_status_color"] as String)
              .replaceAll("#", "0xFF")))
          : Colors.green,
      sisaHariTindakLanjut: json["sisa_hari_tl"],
      statusRekomendasiColor: json["rekomendasi_status_color"] != null
          ? Color(int.parse((json["rekomendasi_status_color"] as String)
              .replaceAll("#", "0xFF")))
          : Colors.green,
      listItem: json["tindak_lanjut"] != null
          ? (json["tindak_lanjut"] as List)
              .map((e) => AuditTLItemModel.fromJson(e))
              .toList()
          : null,
      komentar: json["rekomendasi_komentar"] != null
          ? (json["rekomendasi_komentar"] as List)
              .map((e) => KomentarModel.fromJson(
                    e,
                    tanggalKey: "comment_date",
                    nameKey: "auditor_name",
                    komentarKey: "comment_desc",
                  ))
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
