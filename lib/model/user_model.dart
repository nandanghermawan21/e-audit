import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class UserModel {
  String? userId; //": "9b44ac8966798da6f357fc1689342e187013cd51",
  String? userUsername; //": "fadian",
  String? auditorName; //": null,
  String? groupName; //": "Vendor",
  String? groupId;

  UserModel({
    this.userId,
    this.userUsername,
    this.auditorName,
    this.groupName,
    this.groupId,
  }); //": "a38c99db8e8777d33b3b358d59a47ae1a0c69d66"

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] as String?,
      userUsername: json["user_username"] as String?,
      auditorName: json["auditor_name"] as String?,
      groupName: json["group_name"] as String?,
      groupId: json["group_id"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "user_username": userUsername,
      "auditor_name": auditorName,
      "group_name": groupName,
      "group_id": groupId,
    };
  }

  static Future<UserModel> login({
    required String? username,
    required String? password,
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "login",
        "username": username ?? "",
        "password": password ?? "",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return UserModel.fromJson(((value)["result"]));
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
