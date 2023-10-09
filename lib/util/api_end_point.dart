import 'package:eaudit/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://jamkrindo.banggasolution.com/Api/";
  String baseUrlDebug = "http://jamkrindo.banggasolution.com/Api/";
  // String baseUrl = "https://form.bagdja.com/api/";
  // String baseUrlDebug = "https://form.bagdja.com/api/";

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }
}
