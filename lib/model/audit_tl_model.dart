import 'package:eaudit/model/audit_rekomendasi_model.dart';

class AuditTLModel {
  String? noTemuan;
  String? uraianTemuan;
  String? rekomendasi;
  List<AuditRekomendasiModel?>? listRekomendasi;
  String? judulTemuan;

  AuditTLModel({
    this.noTemuan,
    this.judulTemuan,
    this.uraianTemuan,
    this.rekomendasi,
    this.listRekomendasi,
  });

  Map<String, dynamic> toJson() {
    return {
      "no_temuan": noTemuan,
      "judul_temuan": judulTemuan,
      "uraian_temuan": uraianTemuan,
      "rekomendasi": rekomendasi,
      "list_rekomendasi": listRekomendasi?.map((e) => e?.toJson()).toList(),
    };
  }

  static AuditTLModel fromJson(Map<String, dynamic> json) {
    return AuditTLModel(
      noTemuan: json["no_temuan"],
      judulTemuan: json["judul_temuan"],
      uraianTemuan: json["uraian_temuan"],
      rekomendasi: json["rekomendasi"],
      listRekomendasi: json["list_rekomendasi"] != null
          ? List<AuditRekomendasiModel>.from(
              json["list_rekomendasi"]
                  .map((x) => AuditRekomendasiModel.fromJson(x)),
            )
          : null,
    );
  }

  //dummy
  static List<AuditTLModel> dummys() {
    return <AuditTLModel>[
      AuditTLModel(
        noTemuan: "41341234",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Serang",
        rekomendasi: "4/LHA/II/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        noTemuan: "723452345",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Batam",
        rekomendasi: "4/LHA/I3/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        noTemuan: "9456334566",
        judulTemuan: "Tidak Ada SOP",
        uraianTemuan: "Kantor Cabang Sorong",
        rekomendasi: "14/LHA/I9/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
    ];
  }
}
