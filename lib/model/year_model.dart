import 'dart:async';
import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class YearModel {
  static Widget yearSelector({
    int? selectedYear,
    ValueChanged<int>? onChange,
    Color? dropdownColor,
    Color? textColor,
    Color? iconColor,
    bool? isExpanded,
    Alignment? alignment,
    Text? hint,
    Container? underline,
  }) {
    StreamController<int?> selectedStream = StreamController<int?>();

    return FutureBuilder<List<int>>(
      future: get(token: System.data.global.token),
      builder: (c, f) {
        selectedYear = f.data?.first;
        selectedStream.add(selectedYear);
        onChange!(selectedYear ?? 0);
        return StreamBuilder<int?>(
          initialData: selectedYear,
          stream: selectedStream.stream,
          builder: (c, s) {
            if (f.connectionState != ConnectionState.done) {
              return const Icon(
                Icons.sync,
                color: Colors.white,
              );
            }
            return DropdownButton<int?>(
              value: s.data,
              items: List.generate(
                f.data?.length ?? 0,
                (index) {
                  return DropdownMenuItem<int>(
                    // ignore: sort_child_properties_last
                    child: Text(
                      "${f.data![index]}",
                      style: System.data.textStyles!.basicLightLabel,
                    ),
                    value: f.data![index],
                  );
                },
              ),
              selectedItemBuilder: (ctx) {
                return [
                  Text(
                    "$selectedYear",
                    style: System.data.textStyles!.basicLightLabel,
                  )
                ];
              },
              iconSize: 25,
              iconEnabledColor: Colors.white,
              alignment: Alignment.center,
              isDense: true,
              onChanged: (val) {
                selectedYear = val ?? 0;
                onChange(val ?? 0);
              },
              dropdownColor: System.data.color!.primaryColor,
            );
          },
        );
      },
    );
  }

  static Widget yearSelector2({
    required int? selectedYear,
    required ValueChanged<int?>? onChange,
  }) {
    StreamController<int?> selectedStream = StreamController<int?>();
    return FutureBuilder<List<int?>>(
        future: YearModel.get(
          token: System.data.global.token,
        ),
        builder: (c, s) {
          if (s.connectionState != ConnectionState.done) {
            return const SizedBox(
              width: 100,
              child: Center(
                child: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            if (!(s.data ?? []).contains(selectedYear)) {
              s.data?.add(selectedYear);
            }
            return StreamBuilder<int?>(
              initialData: selectedYear,
              stream: selectedStream.stream,
              builder: (cc, ss) {
              return Container(
                width: 100,
                height: double.infinity,
                color: Colors.transparent,
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: ss.data,
                  underline: Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  hint: Text(
                    System.data.strings!.year,
                    style: System.data.textStyles!.basicLabel.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  items: List.generate(
                    (s.data ?? []).length,
                    (index) {
                      return DropdownMenuItem<int>(
                        value: s.data![index],
                        child: Text("${s.data![index]}",
                            style: System.data.textStyles!.basicLabel),
                      );
                    },
                  ),
                  onChanged: (val) {
                    selectedStream.add(val);
                    onChange?.call(val);
                  },
                ),
              );
            });
          }
        });
  }

  static Future<List<int>> get({
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_tahun",
        "token": token ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return (((value)["result"]["filter_tahun"] as List)
            .map((e) => int.parse((e as String?) ?? "0"))).toList();
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
