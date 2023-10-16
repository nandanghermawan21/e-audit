import 'dart:convert';

import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

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
  List<ActionModel>? actionsLHA;

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
    this.actionsLHA = const [],
  });

  static AuditKKPTModel fromJson(Map<String, dynamic> json) {
    return AuditKKPTModel(
      id: json["finding_id"],
      noTemuan: json["finding_no"],
      judulTemuan: json["finding_judul"],
      tanggalTemuan: DateTime.parse(json["finding_date"]),
      kriteria: json["finding_kriteria"],
      sebab: json["finding_sebab"],
      akibat: json["finding_akibat"],
      lampiranUrl: json["file_url"],
      namaLampiran: json["file_name"],
      rekomendasi: int.parse(json["rekomendasi"]),
      komentar: json["komentar"] != null
          ? List<KomentarModel>.from(
              json["komentar"].map((x) => KomentarModel.fromJson(
                    x,
                    tanggalKey: "find_comment_date",
                    nameKey: "auditor_name",
                    komentarKey: "find_comment_desc",
                  )),
            )
          : null,
      status: json["finding_status"],
      actions: json["action"] != null
          ? List<ActionModel>.from(
              json["action"].map((x) => ActionModel.fromJson(x)),
            )
          : null,
      actionsLHA: json["action_lha"] != null
          ? List<ActionModel>.from(
              json["action_lha"].map((x) => ActionModel.fromJson(x)),
            )
          : null,
    );
  }

  static Future<void> postReviu({
    required String? token,
    required String? findingId,
    required String? status,
    required String? note,
  }) {
    return Network.post(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "post_reviu_kkpt",
        "token": "$token",
      },
      body: {
        "finding_id": "$findingId",
        "status": "$status",
        "note": "$note",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      try {
        value = json.decode(value);
        if ((value)["message"] == "" || (value)["message"] == null) {
          if (value == "success") {
            return;
          } else {
            throw value;
          }
        }
        throw BasicResponse(message: (value)["message"]);
      } catch (e) {
        if (value == "success") {
          return;
        } else {
          throw value;
        }
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<void> postReviuLha({
    required String? token,
    required String? findingId,
    required String? status,
  }) {
    return Network.post(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "post_reviu_kkpt_lha",
        "token": "$token",
      },
      body: {
        "finding_id": "$findingId",
        "status": "$status",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      try {
        value = json.decode(value);
        if ((value)["message"] == "" || (value)["message"] == null) {
          if (value == "success") {
            return;
          } else {
            throw value;
          }
        }
        throw BasicResponse(message: (value)["message"]);
      } catch (e) {
        if (value == "success") {
          return;
        } else {
          throw value;
        }
      }
    }).catchError(
      (onError) {
        throw onError;
      },
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
