import 'package:eaudit/model/audit_tl_reviu_model.dart';

class AuditTLModel {
  String? obyekAudit;
  String? nomorLha;
  List<AuditTLReviuModel>? listAuditTL;

  AuditTLModel({
    this.obyekAudit,
    this.nomorLha,
    this.listAuditTL,
  });

  Map<String, dynamic> toJson() {
    return {
      "obyekAudit": obyekAudit,
      "nomorLha": nomorLha,
      "listAuditTL": listAuditTL?.map((e) => e.toJson()).toList(),
    };
  }

  static AuditTLModel fromJson(Map<String, dynamic> json) {
    return AuditTLModel(
      obyekAudit: json["obyekAudit"],
      nomorLha: json["nomorLha"],
      listAuditTL: json["listAuditTL"] != null
          ? List<AuditTLReviuModel>.from(
              json["listAuditTL"].map((x) => AuditTLReviuModel.fromJson(x)),
            )
          : null,
    );
  }

  //dummy
  static List<AuditTLModel> dummys() {
    return <AuditTLModel>[
      AuditTLModel(
        obyekAudit: "Kantor Cabang Serang",
        nomorLha: "4/LHA/II/2023",
        listAuditTL: AuditTLReviuModel.dummys(),
      ),
      AuditTLModel(
        obyekAudit: "Kantor Cabang Batam",
        nomorLha: "4/LHA/I3/2023",
        listAuditTL: AuditTLReviuModel.dummys(),
      ),
      AuditTLModel(
        obyekAudit: "Kantor Cabang Sorong",
        nomorLha: "14/LHA/I9/2023",
        listAuditTL: AuditTLReviuModel.dummys(),
      ),
    ];
  }
}
