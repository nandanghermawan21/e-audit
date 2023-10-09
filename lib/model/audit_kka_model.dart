import 'dart:convert';

import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditKKAModel {
  String? id;
  String? noKka;
  String? judulKka;
  String? judulProgram;
  DateTime? tanggal;
  String? status;
  String? temuan;
  String? dokumenYangDiperiksa;
  String? uraian;
  String? kesimpulan;
  List<KomentarModel>? komentar;
  List<ActionModel>? actions;
  List<AuditFileModel?>? lampiran;
  bool? proposeKka;
  bool? approveKka;
  String? action;

  AuditKKAModel({
    this.id,
    this.noKka,
    this.judulKka,
    this.judulProgram,
    this.tanggal,
    this.status,
    this.temuan,
    this.actions,
    this.action,
    this.dokumenYangDiperiksa,
    this.uraian,
    this.kesimpulan,
    this.komentar,
    this.lampiran,
    this.proposeKka,
    this.approveKka,
  });

  static AuditKKAModel fromJson(Map<String, dynamic> json) {
    return AuditKKAModel(
      id: json["kertas_kerja_id"],
      noKka: json["kertas_kerja_no"],
      judulProgram: json["judul_program"],
      judulKka: json["kertas_kerja_judul"],
      tanggal: DateTime.parse(json["kertas_kerja_date"]),
      status: json["kertas_kerja_status"],
      temuan: json["jumlah_temuan"],
      actions: json["action"] != null
          ? List<ActionModel>.from(
              json["action"].map((x) => ActionModel.fromJson(x)),
            )
          : null,
      dokumenYangDiperiksa: json["kertas_kerja_dokumen"],
      uraian: json["kertas_kerja_uraian"],
      kesimpulan: json["kertas_kerja_kesimpulan"],
      komentar: json["komentar"] != null
          ? List<KomentarModel>.from(
              json["komentar"].map((x) => KomentarModel.fromJson(
                    x,
                    tanggalKey: "comment_date",
                    nameKey: "auditor_name",
                    komentarKey: "comment_desc",
                  )),
            )
          : null,
      lampiran: json["lampiran"] != null
          ? List<AuditFileModel>.from(
              json["lampiran"].map((x) => AuditFileModel.fromJson(x)),
            )
          : null,
      proposeKka: json["propose_kka"] as bool?,
      approveKka: json["approve_kka"] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "kertas_kerja_id": id,
      "kertas_kerja_no": noKka,
      "judul_program": judulProgram,
      "kertas_kerja_judul": judulKka,
      "kertas_kerja_date": tanggal,
      "kertas_kerja_status": status,
      "jumlah_temuan": temuan,
      "action": actions?.map((e) => e.toJson()).toList(),
      "kertas_kerja_dokumen": dokumenYangDiperiksa,
      "kertas_kerja_uraian": uraian,
      "kertas_kerja_kesimpulan": kesimpulan,
      "komentar": komentar?.map((e) => e.toJson()).toList(),
      "lampiran": lampiran?.map((e) => e?.toJson()).toList(),
    };
  }

  static Future<AuditKKAModel> get({
    required String? token,
    required String? kkaId,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_kertas_kerja_detail",
        "kertas_kerja_id": "$kkaId",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return AuditKKAModel.fromJson(value);
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<void> postReviu({
    required String? token,
    required String? kkaId,
    required String? status,
    required String? note,
  }) {
    return Network.post(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "post_reviu_kka",
        "token": "$token",
      },
      body: {
        "kertas_kerja_id": "$kkaId",
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
        temuan: "3",
        actions: ActionModel.dummy(),
        dokumenYangDiperiksa: "test",
        uraian: "test",
        kesimpulan: "test",
        komentar: KomentarModel.dummy(),
      ),
      AuditKKAModel(
        id: "12",
        noKka: "7/KEU/08/2023",
        judulKka:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        status: "Sedang Direviu Katim",
        temuan: "2",
        actions: ActionModel.dummy(),
        dokumenYangDiperiksa: "test",
        uraian: "test",
        kesimpulan: "test",
        komentar: KomentarModel.dummy(),
      ),
    ];
  }
}
