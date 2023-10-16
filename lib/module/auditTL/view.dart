import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Tindak Lanjut Audit",
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
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YearModel.yearSelector2(
                  selectedYear: model.selectedYear,
                  onChange: (v) {
                    model.selectedYear = v ?? 0;
                    model.commit();
                    listDataComponentController.refresh();
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
                    onChanged: (val) {
                      listDataComponentController.refresh();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: ListDataComponent<AuditTLReviuModel>(
              controller: listDataComponentController,
              enableDrag: false,
              enableGetMore: false,
              dataSource: (skip, key) {
                return AuditTLReviuModel.get(
                  token: System.data.global.token,
                  tahun: model.selectedYear,
                  searchKey: model.searchController.text,
                ).then((value) {
                  return value;
                });
              },
              itemBuilder: (item, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item?.obyekAudit ?? "",
                            style: System.data.textStyles!.boldTitleLabel,
                          ),
                          Text(
                            item?.nomorLha ?? "",
                            style: System.data.textStyles!.boldTitleLabel,
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: button(
                                label: "TL",
                                icon: "assets/icons/temuan.png",
                                data: item,
                                type: "data_tl_internal",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: button(
                                label: "Tindak Lanjut",
                                icon: "assets/icons/rekomendasi.png",
                                data: item,
                                type: "data_tl_eksternal",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: button(
                                  label: "TL ML",
                                  icon: "assets/icons/tindak_lanjut.png",
                                  data: item,
                                  type: "data_tl_management_letter"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget button({
    String? label,
    String? icon,
    AuditTLReviuModel? data,
    String? type,
  }) {
    return GestureDetector(
      onTap: () {
        widget.onSelectItem!(data, type);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: System.data.color!.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label ?? '',
              style: System.data.textStyles!.basicLightLabel.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: System.data.color!.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
