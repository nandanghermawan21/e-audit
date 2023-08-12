import 'package:eaudit/model/action_model.dart';

class AuditKKPTModel {
  String? id;
  String? judulTemuan;
  int? rekomendasi;
  String? status;
  List<ActionModel> actions;

  AuditKKPTModel({
    this.id,
    this.judulTemuan,
    this.rekomendasi,
    this.status,
    this.actions = const [],
  });

  static AuditKKPTModel fromJson(Map<String, dynamic> json) {
    return AuditKKPTModel(
      id: json["id"],
      judulTemuan: json["judul_temuan"],
      rekomendasi: json["rekomendasi"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "judul_temuan": judulTemuan,
      "rekomendasi": rekomendasi,
      "status": status,
    };
  }

  //create list dummy
  static List<AuditKKPTModel> dummys({
    String? status = "PKA",
  }) {
    return [
      AuditKKPTModel(
        judulTemuan: "Tidak ada SOP",
        rekomendasi: 3,
        status: status,
        actions: ActionModel.dummy(),
      ),
      AuditKKPTModel(
        judulTemuan: "Tidak ada Pengawasan",
        rekomendasi: 3,
        status: status,
        actions: ActionModel.dummy(),
      ),
    ];
  }
}
