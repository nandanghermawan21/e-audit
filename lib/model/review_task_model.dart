import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class ReviewTaskModel {
  final String? assignId; //": "fc8878fd7533e34674409c3899fd81de1f1a4558",
  final String?
      assignKegiatan; //": "Audit Penugasan BPK atas Imbal Jasa Penjaminan (IJP) Pemulihan Ekonomi Nasional (PEN) Tahun Anggaran 2022",
  final String? assignDtartDate; //": "1670803200",
  final String? assignEndDate; //": "1673827200",
  final String? jumlahProgram; //": "30",
  final String? jumlahKertasKerja; //": "0",
  final String? statusLhaInternal; //": "Final",
  final String? statusLhaEksternal; //": "Draft",
  final String? statusManagementLetter; //": "Revisi",
  final String? statusAuditRating; //": "Revisi",
  final String? jumlahTemuan; //": "0",
  final String? jumlahRekomendasi; //": "0",
  final StatusTemuan? statusTemuan; //": ,
  final StatusTindakLanjut? statusTindakLanjut;

  ReviewTaskModel({
    this.assignId,
    this.assignKegiatan,
    this.assignDtartDate,
    this.assignEndDate,
    this.jumlahProgram,
    this.jumlahKertasKerja,
    this.statusLhaInternal,
    this.statusLhaEksternal,
    this.statusManagementLetter,
    this.statusAuditRating,
    this.jumlahTemuan,
    this.jumlahRekomendasi,
    this.statusTemuan,
    this.statusTindakLanjut,
  }); //":

  static ReviewTaskModel fromJson(Map<String, dynamic> json) {
    return ReviewTaskModel(
        assignId: json["assign_id"] as String?,
        assignKegiatan: json["assign_kegiatan"] as String?,
        assignDtartDate: json["assign_start_date"] as String?,
        assignEndDate: json["assign_end_date"] as String?,
        jumlahProgram: json["jumlah_program"] as String?,
        jumlahKertasKerja: json["jumlah_kertas_kerja"] as String?,
        statusLhaInternal: json["status_lha_internal"] as String?,
        statusLhaEksternal: json["status_lha_eksternal"] as String?,
        statusManagementLetter: json["status_management_letter"] as String?,
        statusAuditRating: json["status_audit_rating"] as String?,
        jumlahTemuan: json["jumlah_temuan"] as String?,
        jumlahRekomendasi: json["jumlah_rekomendasi"] as String?,
        statusTemuan: StatusTemuan.fromJson(
            json["status_temuan"] as Map<String, dynamic>? ?? {}),
        statusTindakLanjut: StatusTindakLanjut.fromJson(
            json["status_tindak_lanjut"] as Map<String, dynamic>? ?? {}));
  }

  static Future<List<ReviewTaskModel>> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_review_task",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return (((value)["result"]["data_pelaksanaan"] as List)
            .map((e) => ReviewTaskModel.fromJson(e))).toList();
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}

class StatusTemuan {
  final String? temuanKatim; //": "0",
  final String? temuanManager; //": "0",
  final String? temuanLha;

  StatusTemuan({
    this.temuanKatim,
    this.temuanManager,
    this.temuanLha,
  }); //": "0"

  static StatusTemuan fromJson(Map<String, dynamic> json) {
    return StatusTemuan(
      temuanKatim: json["temuan_katim"] as String?,
      temuanManager: json["temuan_manager"] as String?,
      temuanLha: json["temuan_lha"] as String?,
    );
  }
}

class StatusTindakLanjut {
  final String? selesai; //": "0",
  final String? belumSelesai; //": "0",
  final String? belumTl;

  StatusTindakLanjut({
    this.selesai,
    this.belumSelesai,
    this.belumTl,
  }); //": "0"

  static StatusTindakLanjut fromJson(Map<String, dynamic> json) {
    return StatusTindakLanjut(
      selesai: json["selesai"] as String?,
      belumSelesai: json["belum_selesai"] as String?,
      belumTl: json["belum_tl"] as String?,
    );
  }
}
