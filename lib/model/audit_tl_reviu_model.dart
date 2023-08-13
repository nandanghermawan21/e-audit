import 'package:eaudit/model/audit_tl_model.dart';

class AuditTLReviuModel {
  String? obyekAudit;
  String? nomorLha;
  List<AuditTLModel?>? listAuditTL;

  AuditTLReviuModel({
    this.obyekAudit,
    this.nomorLha,
    this.listAuditTL,
  });

  Map<String, dynamic> toJson() {
    return {
      "obyekAudit": obyekAudit,
      "nomorLha": nomorLha,
      "listAuditTL": listAuditTL?.map((e) => e?.toJson()).toList(),
    };
  }

  static AuditTLReviuModel fromJson(Map<String, dynamic> json) {
    return AuditTLReviuModel(
      obyekAudit: json["obyekAudit"],
      nomorLha: json["nomorLha"],
      listAuditTL: json["listAuditTL"] != null
          ? List<AuditTLModel>.from(
              json["listAuditTL"].map((x) => AuditTLModel.fromJson(x)),
            )
          : null,
    );
  }

  //dummy
  static List<AuditTLReviuModel> dummys() {
    return <AuditTLReviuModel>[
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Serang",
        nomorLha: "4/LHA/II/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Batam",
        nomorLha: "4/LHA/I3/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Sorong",
        nomorLha: "14/LHA/I9/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
    ];
  }
}
