import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';

class NotificationModel {
  String? title;
  String? body;
  String? tyoe;
  Map<String, dynamic>? data;

  NotificationModel({
    this.title,
    this.body,
    this.tyoe,
    this.data,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    tyoe = json['tyoe'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'tyoe': tyoe,
      'data': data,
    };
  }

  //dummy
  static List<NotificationModel> dummy() {
    return [
      NotificationModel(
        title: 'PKA baru perlu reviu anda',
        body:
            'Pelaksanaan Operasional Administrasi dan Kepatuhan Divisi Akuntansi',
        tyoe: 'PKA',
        data: AuditPKAModel.dummy().toJson(),
      ),
      NotificationModel(
        title: 'KKA baru perlu reviu anda',
        body: 'Divisi Akuntasni - Andreas',
        tyoe: 'KKA',
        data: AuditkaReviuModel.dummy().toJson(),
      ),
      NotificationModel(
        title: 'KKPT baru perlu reviu anda',
        body: 'Divisi Akuntasni - Andreas',
        tyoe: 'KKPT',
        data: AuditKKPTReviuModel.dummy().toJson(),
      ),
      NotificationModel(
        title: 'Rekomendari baru perlu reviu anda',
        body:
            'Peneritan Sertifikat Penjaminan Kontra ank Garansi Meleihi atas Service Level Agreement (SLA) yang di tntukan pada perjanjian \n Pemimpin caang serang agar memeri intruksi tertulis kepada manager isnis KC Serang untuk menindaklanjuti rekomendasi ini',
        tyoe: 'TL',
        data: AuditTLReviuModel.dummys().first.toJson(),
      ),
    ];
  }
}
