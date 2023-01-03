import 'dart:convert';
import 'dart:ui';

import 'package:eaudit/model/pie_chart_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditRatingUnitKerjaModel {
  final List<String?>? ratingAuditee;
  final List<Color?>? ratingAuditeeColor;
  final List<int?>? ratingAuditeeKlasifikasi;

  AuditRatingUnitKerjaModel({
    this.ratingAuditee,
    this.ratingAuditeeColor,
    this.ratingAuditeeKlasifikasi,
  });

  static AuditRatingUnitKerjaModel fromJson(Map<String, dynamic> json) {
    return AuditRatingUnitKerjaModel(
      ratingAuditee:
          (json["rating_auditee"] as List).map((e) => e as String?).toList(),
      ratingAuditeeColor: (json["rating_auditee_color"] as List)
          .map((e) => Color(
              int.parse((e as String? ?? "#000000").replaceAll("#", "0xff"))))
          .toList(),
      ratingAuditeeKlasifikasi: (json["rating_auditee_klasifikasi"] as List)
          .map((e) => int.parse(e as String? ?? "0"))
          .toList(),
    );
  }

  static Future<AuditRatingUnitKerjaModel> get({
    required String? token,
    required int? tahun,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_rating_auditee",
        "tahun": "$tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return AuditRatingUnitKerjaModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  PieChartModel toPieChartData() {
    PieChartModel data = PieChartModel(
      data: List.generate(
        ratingAuditee?.length ?? 0,
        (i) {
          return PieChartDataModel(
            domain: ratingAuditee?[i],
            color: ratingAuditeeColor![i],
            total: ratingAuditeeKlasifikasi![i],
          );
        },
      ),
    );

    return data;
  }
}
