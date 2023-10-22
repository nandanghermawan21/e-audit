import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class ManualBookModel {
  final String? name;
  final String? url;

  ManualBookModel({
    this.name,
    this.url,
  });

  static ManualBookModel fromJson(Map<String, dynamic> json) {
    return ManualBookModel(
      name: json["manual_book_title"],
      url: json["manual_book_link"],
    );
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
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value as List)
          .map<ManualBookModel>((e) => ManualBookModel.fromJson(e))
          .toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
