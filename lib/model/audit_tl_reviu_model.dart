import 'package:eaudit/model/audit_rekomendasi_model.dart';

class AuditTLReviuModel {
  String? uraianTemuan;
  String? rekomendasi;
  List<AuditRekomendasiModel?>? listRekomendasi;

  AuditTLReviuModel({
    this.uraianTemuan,
    this.rekomendasi,
    this.listRekomendasi,
  });

  Map<String, dynamic> toJson() {
    return {
      "uraian_temuan": uraianTemuan,
      "rekomendasi": rekomendasi,
      "list_rekomendasi": listRekomendasi,
    };
  }

  static AuditTLReviuModel fromJson(Map<String, dynamic> json) {
    return AuditTLReviuModel(
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
  static List<AuditTLReviuModel> dummys() {
    return <AuditTLReviuModel>[
      AuditTLReviuModel(
        uraianTemuan: "Kantor Cabang Serang",
        rekomendasi: "4/LHA/II/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLReviuModel(
        uraianTemuan: "Kantor Cabang Batam",
        rekomendasi: "4/LHA/I3/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLReviuModel(
        uraianTemuan: "Kantor Cabang Sorong",
        rekomendasi: "14/LHA/I9/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
    ];
  }
}
