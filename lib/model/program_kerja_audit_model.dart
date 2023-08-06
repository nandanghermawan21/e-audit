import 'package:eaudit/model/anggota_model.dart';
import 'package:eaudit/model/program_audit_model.dart';

class ProgramKerjaAuditModel {
  String? namaKegiatan;
  String? auditee;
  String? tipeAudit;
  DateTime? tanggalAudit;
  List<AnggotaModel>? anggota;
  List<ProgramAuditModel>? programAudit;

  ProgramKerjaAuditModel({
    this.namaKegiatan,
    this.auditee,
    this.tipeAudit,
    this.tanggalAudit,
    this.anggota,
    this.programAudit,
  });

  static ProgramKerjaAuditModel fromJson(Map<String, dynamic> json) {
    return ProgramKerjaAuditModel(
      namaKegiatan: json["nama_kegiatan"],
      auditee: json["auditee"],
      tipeAudit: json["tipe_audit"],
      tanggalAudit: DateTime.parse(json["tanggal_audit"]),
      anggota: (json["anggota"] as List)
          .map((e) => AnggotaModel.fromJson(e))
          .toList(),
      programAudit: (json["program_audit"] as List)
          .map((e) => ProgramAuditModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nama_kegiatan": namaKegiatan,
      "auditee": auditee,
      "tipe_audit": tipeAudit,
      "tanggal_mulai": tanggalAudit,
      "anggota": anggota?.map((e) => e.toJson()).toList(),
    };
  }

  //create list dummy
  static ProgramKerjaAuditModel dummy() {
    return ProgramKerjaAuditModel(
      namaKegiatan:
          "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
      auditee: "Divisi Akuntansi",
      tipeAudit: "PKA",
      tanggalAudit: DateTime.parse("2021-09-01 08:00:00"),
      anggota: AnggotaModel.dummys(),
      programAudit: ProgramAuditModel.dummys(),
    );
  }
}
