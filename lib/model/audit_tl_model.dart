import 'package:eaudit/model/audit_rekomendasi_model.dart';

class AuditTLModel {
  String? uraianTemuan;
  String? rekomendasi;
  List<AuditRekomendasiModel?>? listRekomendasi;

  AuditTLModel({
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

  static AuditTLModel fromJson(Map<String, dynamic> json) {
    return AuditTLModel(
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
        uraianTemuan: "Kantor Cabang Serang",
        rekomendasi: "4/LHA/II/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        uraianTemuan: "Kantor Cabang Batam",
        rekomendasi: "4/LHA/I3/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
      AuditTLModel(
        uraianTemuan: "Kantor Cabang Sorong",
        rekomendasi: "14/LHA/I9/2023",
        listRekomendasi: AuditRekomendasiModel.dummys(),
      ),
    ];
  }
}
