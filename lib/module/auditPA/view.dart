import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
      ),
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
              YearModel.yearSelector2(
                  selectedYear: model.selectedYear,
                  onChange: (v) {
                    model.selectedYear = v ?? 0;
                    model.commit();
                    listController.refresh();
                  }),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  height: 31,
                  color: Colors.transparent,
                  child: TextField(
                    controller: model.searchController,
                    decoration: const InputDecoration(
                      hintText: "Cari",
                      contentPadding: EdgeInsets.only(
                          left: 1, right: 1, top: 5, bottom: 12),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (val){
                      listController.refresh();
                    },
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
                return AuditPaModel.get(
                  token: System.data.global.token,
                  tahun: model.selectedYear,
                  searchKey: model.searchController.text,
                  type: widget.type,
                ).then((value) {
                  return value;
                });
              },
              itemBuilder: (data, index) {
                return itemPka(data);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget itemPka(AuditPaModel? data) {
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
                    (data?.divisi ?? ""),
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
                    widget.type,
                    style: System.data.textStyles!.basicLabel,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
