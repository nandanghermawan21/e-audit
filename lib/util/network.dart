import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/system.dart';

class Network {
  static Future<dynamic> post({
    required Uri url,
    Map<String, String>? querys,
    String? relativeUrl = "",
    Map<String, dynamic>? body,
    List? bodies,
    Encoding? encoding,
    Map<String, String>? headers,
    ValueChanged<BasicResponse>? otpRequired,
    ValueChanged<BasicResponse>? unAuthorized,
  }) {
    DateTime timeStamp = DateTime.now();

    Map<String, String> newHeaders = headers ?? {};

    newHeaders.addAll(
      {
        "Content-Type": "application/json",
        "Client-Timestamp": formatISOTime(timeStamp),
        "Access-Control_Allow_Origin": "*",
        "deviceImei": System.data.deviceInfo?.imei ?? "",
        "deviceId": System.data.deviceInfo?.deviceId ?? "",
        "deviceModel": System.data.deviceInfo?.deviceModel ?? "",
        "deviceOs": Platform.isAndroid ? "A" : "I",
        "deviiceOsVersion": Platform.operatingSystemVersion,
        "appVersion": System.data.versionName,
        "appVersionCode": "${System.data.versionCode}",
        "messagingToken": "${System.data.global.messagingToken}",
      },
    );

    Map<String, String> newQuery = {};
    if (url.hasQuery) {
      newQuery.addAll(url.queryParameters);
    }
    if (querys != null && querys.isNotEmpty) {
      newQuery.addAll(querys);
    }

    Uri uri = Uri(
      fragment: url.fragment,
      scheme: url.scheme,
      host: url.host,
      path: url.path,
      port: url.port,
      queryParameters: newQuery,
      userInfo: url.userInfo,
    );

    return http
        .post(
      uri,
      body: json.encode(bodies ?? body),
      // encoding: encoding ?? Encoding.getByName("apliaction/json"),
      headers: newHeaders,
    )
        .then(
      (http.Response response) {
        try {
          debugPrint("POST ${uri.toString()}");
          debugPrint("body ${json.encode(body)}");
          debugPrint("response ${response.body}");
          return handleResponse(
            response,
            otpRequired: otpRequired,
            unAuthorized: unAuthorized,
          );
        } catch (e) {
          if (e is SocketException) {
            throw SocketException(System.data.strings!.internetConnestionError);
          } else {
            rethrow;
          }
        }
      },
    ).catchError((e) {
      if (e is SocketException) {
        throw SocketException(System.data.strings!.internetConnestionError);
      } else {
        throw e;
      }
    });
  }

  static Future<dynamic> get({
    required Uri url,
    Map<String, String>? querys,
    String? relativeUrl = "",
    Encoding? encoding,
    Map<String, String>? headers,
    ValueChanged<BasicResponse>? otpRequired,
    ValueChanged<BasicResponse>? unAuthorized,
    bool printResolt = true,
    bool rawResult = false,
  }) {
    DateTime timeStamp = DateTime.now();

    Map<String, String> newHeaders = headers ?? {};

    newHeaders.addAll({
      "Content-Type": "application/json",
      "Client-Timestamp": formatISOTime(timeStamp),
      'Access-Control-Allow-Origin': '*', // Replace your domain
      'Access-Control-Allow-Methods': 'POST, GET, DELETE, HEAD, OPTIONS',
      "deviceImei": System.data.deviceInfo?.imei ?? "",
      "deviceId": System.data.deviceInfo?.deviceId ?? "",
      "deviceModel": System.data.deviceInfo?.deviceModel ?? "",
      "deviceOs": Platform.isAndroid ? "A" : "I",
      "deviiceOsVersion": Platform.operatingSystemVersion,
      "appVersion": System.data.versionName,
      "appVersionCode": "${System.data.versionCode}",
      "messagingToken": "${System.data.global.messagingToken}",
      "User-Agent": "PostmanRuntime/7.33.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
    });

    Map<String, String> newQuery = {};
    if (url.hasQuery) {
      newQuery.addAll(url.queryParameters);
    }
    if (querys != null && querys.isNotEmpty) {
      newQuery.addAll(querys);
    }

    Uri uri = Uri(
      fragment: url.fragment,
      scheme: url.scheme,
      host: url.host,
      path: url.path,
      port: url.port,
      queryParameters: newQuery,
      userInfo: url.userInfo,
    );

    return http
        .get(
      uri,
      headers: newHeaders,
    )
        .then(
      (http.Response response) {
        debugPrint("GET ${uri.toString()}");
        if (printResolt == true) {
          debugPrint("response ${response.body}");
        }
        try {
          if (rawResult == false) {
            return handleResponse(
              response,
              otpRequired: otpRequired,
              unAuthorized: unAuthorized,
            );
          } else {
            return response.body;
          }
        } catch (e) {
          if (e is SocketException) {
            throw SocketException(System.data.strings!.internetConnestionError);
          } else {
            rethrow;
          }
        }
      },
    ).catchError((e) {
      if (e is SocketException) {
        throw SocketException(System.data.strings!.internetConnestionError);
      } else {
        throw e;
      }
    });
  }

  static handleResponse(
    http.Response response, {
    ValueChanged<BasicResponse>? otpRequired,
    ValueChanged<BasicResponse>? unAuthorized,
  }) {
    final String res = response.body;
    final int statusCode = response.statusCode;
    if (statusCode != 200) {
      switch (statusCode) {
        case 401:
          if (System.data.onUnAuthorized != null) {
            System.data.onUnAuthorized!();
          }
          break;
        default:
          throw response;
      }
    } else {
      BasicResponse basicResponse = BasicResponse.fromJson(json.decode(res));
      if (!BasicResponseStatus.successCodes.contains(basicResponse.status)) {
        switch (basicResponse.status) {
          case BasicResponseStatus.otpRequired:
            if (otpRequired != null) {
              otpRequired(basicResponse);
              return null;
            } else {
              throw basicResponse;
            }
          case BasicResponseStatus.unAuthorized1:
          case BasicResponseStatus.unAuthorized2:
            if (unAuthorized != null) {
              unAuthorized(basicResponse);
              return;
            } else if (System.data.onUnAuthorized != null) {
              System.data.onUnAuthorized!();
            } else {
              throw basicResponse;
            }
            break;
          default:
            throw basicResponse;
        }
      } else {
        switch (basicResponse.status) {
          case BasicResponseStatus.successWithData:
            return basicResponse.data as dynamic;
          default:
            return res;
        }
      }
    }
  }

  static String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }
}
