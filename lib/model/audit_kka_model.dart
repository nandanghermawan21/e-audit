import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/komentar_model.dart';

class AuditKKAModel {
  String? id;
  String? noKka;
  String? judulKka;
  DateTime? tanggal;
  String? status;
  int? temuan;
  String? dokumenYangDiperiksa;
  String? uraian;
  String? kesimpulan;
  String? fileKertasKerja;
  String? urlFileKertasKerja;
  List<KomentarModel>? komentar;
  List<ActionModel>? actions;
  String? action;

  AuditKKAModel({
    this.id,
    this.noKka,
    this.judulKka,
    this.tanggal,
    this.status,
    this.temuan,
    this.actions,
    this.action,
    this.dokumenYangDiperiksa,
    this.uraian,
    this.kesimpulan,
    this.fileKertasKerja,
    this.komentar,
    this.urlFileKertasKerja,
  });

  static AuditKKAModel fromJson(Map<String, dynamic> json) {
    return AuditKKAModel(
      id: json["kertas_kerja_id"],
      noKka: json["kertas_kerja_no"],
      judulKka: json["kertas_kerja_judul"],
      tanggal: DateTime.parse(json["kertas_kerja_date"]),
      status: json["kertas_kerja_status"],
      temuan: json["temuan"],
      actions: ActionModel.dummy(),
      // actions: json["action"] != null
      //     ? List<ActionModel>.from(
      //         json["action"].map((x) => ActionModel.fromJson(x)),
      //       )
      //     : null,
      dokumenYangDiperiksa: json["dokumen_yang_diperiksa"],
      uraian: json["kertas_kerja_uraian"],
      kesimpulan: json["kertas_kerja_kesimpulan"],
      fileKertasKerja: json["file_kertas_kerja"],
      urlFileKertasKerja: json["kertas_kerja_file_url"],
      komentar: json["komentar"] != null
          ? List<KomentarModel>.from(
              json["komentar"].map((x) => KomentarModel.fromJson(
                    x,
                    tanggalKey: "kertas_kerja_comment_date",
                    nameKey: "auditor_name",
                    komentarKey: "kertas_kerja_comment_desc",
                  )),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "no_kka": noKka,
      "judul_kka": judulKka,
      "tanggal": tanggal?.toIso8601String(),
      "status": status,
      "temuan": temuan,
      "action": actions != null
          ? List<dynamic>.from(actions!.map((x) => x.toJson()))
          : null,
      "dokumen_yang_diperiksa": dokumenYangDiperiksa,
      "uraian": uraian,
      "kesimpulan": kesimpulan,
      "file_kertas_kerja": fileKertasKerja,
      "url_file_kertas_kerja": urlFileKertasKerja,
      "komentar": komentar?.map((e) => e.toJson()).toList(),
    };
  }

  //create list dummy
  static List<AuditKKAModel> dummys() {
    return [
      AuditKKAModel(
        id: "11",
        noKka: "6/KEU/08/2023",
        judulKka:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan ",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        status: "Sedang Direviu Katim",
        temuan: 3,
        actions: ActionModel.dummy(),
        dokumenYangDiperiksa: "test",
        uraian: "test",
        kesimpulan: "test",
        fileKertasKerja: "file.pdf",
        urlFileKertasKerja: "test",
        komentar: KomentarModel.dummy(),
      ),
      AuditKKAModel(
        id: "12",
        noKka: "7/KEU/08/2023",
        judulKka:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        status: "Sedang Direviu Katim",
        temuan: 2,
        actions: ActionModel.dummy(),
        dokumenYangDiperiksa: "test",
        uraian: "test",
        kesimpulan: "test",
        fileKertasKerja: "file.pdf",
        urlFileKertasKerja: "test",
        komentar: KomentarModel.dummy(),
      ),
    ];
  }
}
