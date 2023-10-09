import 'package:eaudit/model/komentar_model.dart';

class ProgramAuditModel {
  String? id;
  String? judul;
  String? langkahKerja;
  String? pelaksana;
  String? jumlahHari;
  String? status;
  int? totalKKA;
  int? totalTemuan;
  int? totalRekomendasi;
  List<KomentarModel>? komentar;

  String? catatan;
  String? approve;

  //constructor
  ProgramAuditModel({
    this.id,
    this.judul,
    this.langkahKerja,
    this.pelaksana,
    this.jumlahHari,
    this.status,
    this.totalKKA,
    this.totalTemuan,
    this.totalRekomendasi,
    this.komentar,
    this.catatan,
    this.approve,
  });

  //convert json to model
  static ProgramAuditModel fromJson(Map<String, dynamic> json) {
    return ProgramAuditModel(
      id: json["program_id"],
      judul: json["judul"],
      langkahKerja: json["langkah_kerja"],
      pelaksana: json["pelaksana"],
      jumlahHari: json["jumlah_hari"],
      status: json["program_status"],
      totalKKA: int.parse(json["total_kka"]),
      totalTemuan: int.parse(json["total_temuan"]),
      totalRekomendasi: int.parse(json["total_rekomendasi"]),
      komentar: (json["komentar"] as List)
          .map((e) => KomentarModel.fromJson(
                e,
                tanggalKey: "program_comment_date",
                nameKey: "auditor_name",
                komentarKey: "program_comment_desc",
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toPostReviu() {
    return {
      "program_id": id,
      "status": approve,
      "note": catatan,
    };
  }

  //create list dummy
  static List<ProgramAuditModel> dummys() {
    return [
      ProgramAuditModel(
        judul: "ASET - Penilaian (Agus Mirazul Fajar)",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
      ProgramAuditModel(
        judul: "ASET - Penilaian (Agus Mirazul Fajar)",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
      ProgramAuditModel(
        judul: "ASET - Penilaian ((Agus Mirazul Fajar))",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
    ];
  }
}
