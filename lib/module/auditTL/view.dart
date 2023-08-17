import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(0),
            child: ListDataComponent<AuditTLReviuModel>(
              controller: listDataComponentController,
              enableDrag: false,
              enableGetMore: false,
              dataSource: (skip, key) {
                return Future.value().then((value) {
                  return AuditTLReviuModel.dummys();
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
                                label: "Matriks TL",
                                icon: "assets/icons/temuan.png",
                                data: item,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: button(
                                label: "Matrikx Tindak Lanjut",
                                icon: "assets/icons/rekomendasi.png",
                                data: item,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: button(
                                label: "Matriks TL ML",
                                icon: "assets/icons/tindak_lanjut.png",
                                data: item,
                              ),
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
  }) {
    return GestureDetector(
      onTap: () {
        widget.onSelectItem!(data);
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
