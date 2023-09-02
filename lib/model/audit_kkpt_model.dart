import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/komentar_model.dart';

class AuditKKPTModel {
  String? id;
  String? noTemuan;
  String? judulTemuan;
  DateTime? tanggalTemuan;
  String? kriteria;
  String? sebab;
  String? akibat;
  String? lampiranUrl;
  String? namaLampiran;
  int? rekomendasi;
  String? status;
  bool? masukLha;
  List<KomentarModel>? komentar;
  List<ActionModel>? actions;

  AuditKKPTModel({
    this.id,
    this.noTemuan,
    this.judulTemuan,
    this.tanggalTemuan,
    this.kriteria,
    this.sebab,
    this.akibat,
    this.lampiranUrl,
    this.namaLampiran,
    this.rekomendasi,
    this.status,
    this.komentar,
    this.masukLha,
    this.actions = const [],
  });

  static AuditKKPTModel fromJson(Map<String, dynamic> json) {
    return AuditKKPTModel(
      id: json["id"],
      noTemuan: json["no_temuan"],
      judulTemuan: json["judul_temuan"],
      tanggalTemuan: DateTime.parse(json["tanggal_temuan"]),
      kriteria: json["kriteria"],
      sebab: json["sebab"],
      akibat: json["akibat"],
      lampiranUrl: json["lampiran_url"],
      namaLampiran: json["lampiran_nama"],
      rekomendasi: json["rekomendasi"],
      komentar: json["komentar"] != null
          ? List<KomentarModel>.from(
              json["komentar"].map((x) => KomentarModel.fromJson(x)),
            )
          : null,
      status: json["status"],
      actions: json["actions"] != null
          ? List<ActionModel>.from(
              json["actions"].map((x) => ActionModel.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "judul_temuan": judulTemuan,
      "tanggal_temuan": tanggalTemuan?.toIso8601String(),
      "kriteria": kriteria,
      "sebab": sebab,
      "akibat": akibat,
      "lampiran": lampiranUrl,
      "rekomendasi": rekomendasi,
      "komentar": komentar?.map((e) => e.toJson()).toList(),
      "status": status,
      "actions": actions?.map((e) => e.toJson()).toList(),
    };
  }

  //create list dummy
  static List<AuditKKPTModel> dummys({
    String? status = "PKA",
  }) {
    return [
      AuditKKPTModel(
        id: "1",
        noTemuan: "142341234",
        judulTemuan: "Tidak ada SOP",
        rekomendasi: 3,
        status: "Sedang di reviu katim",
        kriteria: "Kriteria 1",
        tanggalTemuan: DateTime.parse("2021-09-01 08:00:00"),
        sebab: "Tidak ada SOP",
        akibat: "Pekerjaan kurang efektif",
        actions: ActionModel.dummy(),
        komentar: KomentarModel.dummy(),
        lampiranUrl:
            "https://pslb3.menlhk.go.id/internal/uploads/pengumuman/1545111808_contoh-pdf.pdf",
        namaLampiran: "lampiran",
      ),
      AuditKKPTModel(
        id: "1",
        noTemuan: "142341234",
        judulTemuan: "Tidak ada SOP",
        rekomendasi: 3,
        status: "Sudah Disetujui",
        kriteria: "Kriteria 1",
        tanggalTemuan: DateTime.parse("2021-09-01 08:00:00"),
        sebab: "Tidak ada SOP",
        akibat: "Pekerjaan kurang efektif",
        actions: ActionModel.kkptDisetujui(),
        komentar: KomentarModel.dummy(),
        namaLampiran: "Lampiran",
        lampiranUrl:
            "https://pslb3.menlhk.go.id/internal/uploads/pengumuman/1545111808_contoh-pdf.pdf",
      ),
    ];
  }
}
