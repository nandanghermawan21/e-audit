import 'dart:convert';

import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class CheckAccessModel {
  static Future<bool> get({
    required String? token,
    required String? method,
    required String? group,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "check_access",
        "menu": method ?? "",
        "group": "$group",
        "token": token ?? "",
      },
    ).then((value) {
      return json.decode(value)["message"] as bool? ?? false;
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
