import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sqflite.dart';

class NotificationModel {
  String? userId;
  String? notifId;
  String? title;
  String? body;
  DateTime? receivedDate;
  String? dataType;
  String? dataId;

  NotificationModel({
    this.userId,
    this.notifId,
    this.title,
    this.body,
    this.receivedDate,
    this.dataType,
    this.dataId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    notifId = json['notif_id'];
    title = json['title'];
    body = json['body'];
    receivedDate = DateTime.parse(json['received_date']);
    dataType = json['type'];
    dataId = json['data_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "notif_id": notifId,
      "title": title,
      "body": body,
      "received_date": receivedDate?.toIso8601String(),
      "type": dataType,
      "data_id": dataId,
    };
  }

  static Future<List<NotificationModel>?> getFromDb({
    required Database? db,
    required String? userId,
  }) {
    return rootBundle
        .loadString("dbquery/SelectNotifByUser.sql")
        .then((sql) async {
      sql = sprintf(sql, [
        userId,
      ]);
      return db?.rawQuery(sql).then((value) {
        debugPrint(json.encode(value));
        return value.map((e) => NotificationModel.fromJson(e)).toList();
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  Future<int?> saveToDb({
    required Database? db,
  }) {
    return rootBundle.loadString("dbquery/InsertNotif.sql").then((sql) async {
      sql = sprintf(sql, [
        userId,
        notifId,
        title,
        body,
        receivedDate?.toIso8601String(),
        dataType,
        dataId,
      ]);
      return db?.rawInsert(sql).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }
}
