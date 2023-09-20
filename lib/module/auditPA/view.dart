import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Daftar Pelaksanaan Audit",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            color: Colors.transparent,
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: double.infinity,
                color: Colors.transparent,
                child: DropdownButton<int>(
                  isExpanded: true,
                  hint: Text(
                    System.data.strings!.year,
                    style: System.data.textStyles!.basicLabel.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  items: List.generate(
                    5,
                    (index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text("${2023 - index}}",
                            style: System.data.textStyles!.basicLabel),
                      );
                    },
                  ),
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  height: 32,
                  color: Colors.transparent,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      hintText: "Cari",
                      contentPadding: EdgeInsets.only(
                        left: 1,
                        right: 1,
                        top: 5,
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: ListDataComponent<AuditPaModel>(
              controller: listController,
              enableDrag: false,
              enableGetMore: false,
              dataSource: (skip, key) {
                return Future.value().then(
                  (value) {
                    return AuditPaModel.dummys(
                      status: widget.type,
                    );
                  },
                );
              },
              itemBuilder: (data, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onTapItem!(data);
                  },
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                               ( data?.divisi ?? ""),
                                style: System.data.textStyles!.boldTitleLabel,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${data?.tanggalMulai == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
                                    (data!.tanggalMulai!),
                                  )}\ns/d ${data?.tanggalSelesai == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
                                    (data!.tanggalSelesai!),
                                  )}",
                                style: System.data.textStyles!.boldTitleLabel,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data?.kegiatan ?? "",
                                style: System.data.textStyles!.basicLabel,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                data?.status ?? "",
                                style: System.data.textStyles!.basicLabel,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
