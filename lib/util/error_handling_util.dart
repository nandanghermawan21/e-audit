import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/mode_util.dart';

class ErrorHandlingUtil {
  static handleApiError(
    dynamic error, {
    String? prefix = "",
    String? onTimeOut = "",
  }) {
    String message = "";

    if (error is BasicResponse) {
      message = error.message ?? "";
    } else if (error is FormatException) {
      message = error.toString();
    } else if (error is http.Response) {
      message = error.body;
    } else {
      message = error.toString();
    }

    message = "$prefix $message";

    ModeUtil.debugPrint("error $prefix $message");
    return message;
  }

  static String readMessage(http.Response response) {
    try {
      return json.decode(response.body)["Message"].toString() == ""
          ? defaultMessage(response)
          : json.decode(response.body)["Message"].toString();
    } catch (e) {
      return defaultMessage(response);
    }
  }

  static String defaultMessage(http.Response response) {
    return "${response.body.isNotEmpty ? response.body : response.statusCode}";
  }
}
