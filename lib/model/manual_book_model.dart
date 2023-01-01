import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:intl/intl.dart';

class ManualBookModel {
  final String? name;
  final String? url;

  ManualBookModel({
    this.name,
    this.url,
  });

  static List<ManualBookModel> fromJson(Map<String, dynamic> json) {
    List<ManualBookModel> data = [];

    for (var a in json.keys) {
      data.add(ManualBookModel(
        name: toBeginningOfSentenceCase(a.replaceAll("_", " ")),
        url: json[a],
      ));
    }

    return data;
  }

  static Future<List<ManualBookModel>> get({
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_manual_book",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return ManualBookModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
