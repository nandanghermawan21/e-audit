import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/report_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Report",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            color: Colors.transparent,
            child: YearModel.yearSelector(
                selectedYear: selectedYear,
                onChange: (val) {
                  selectedYear = val;
                  listController.refresh();
                }),
          )
        ],
      ),
      body: Container(
        color: const Color(0xffF4F4F4),
        child: ListDataComponent<ReportModel>(
          controller: listController,
          enableDrag: false,
          enableGetMore: false,
          dataSource: (skip, search) {
            return ReportModel.get(
              token: System.data.global.token,
              tahun: selectedYear,
            );
          },
          itemBuilder: (data, index) {
            return Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detail(
                    value: data?.lhaNomor,
                  ),
                  detail(
                    label: "Jenis Auditee Name",
                    value: data?.jenisAuditee,
                  ),
                  detail(
                    label: "Auditee Name",
                    value: data?.auditee,
                  ),
                  documentReport(
                    data: data,
                    title: "LHA Internal",
                    url: data?.linkLhaEksternal,
                  ),
                  documentReport(
                    data: data,
                    title: "LHA External",
                    url: data?.linkLhaEksternal,
                  ),
                  documentReport(
                    data: data,
                    title: "Management Letter",
                    url: data?.linkMl,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget detail({
    String? label,
    String? value,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: Text(
              label ?? "LHA No",
              style: System.data.textStyles!.basicLabel,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: Text(
              value ?? "-",
              style: System.data.textStyles!.basicLabel,
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  Widget documentReport({
    ReportModel? data,
    String? title,
    String? url,
  }) {
    return GestureDetector(
      onTap: () {
        if (url != null && url != "") {
          widget.onTapDocument(
              "${data?.lhaNomor ?? ""}\n${title ?? ""} ${data?.jenisAuditee ?? ""}\n${data?.auditee ?? ""}",
              url);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black38,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Text(
                  title ?? "LHA Internal",
                  style: System.data.textStyles!.basicLabel,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 50,
              color: Colors.transparent,
              child: Icon(
                url != null && url != ""
                    ? FontAwesomeIcons.filePdf
                    : FontAwesomeIcons.minus,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
