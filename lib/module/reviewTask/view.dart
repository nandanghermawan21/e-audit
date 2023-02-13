import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/review_task_model.dart';
import 'package:eaudit/model/year_model.dart';
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
          "Reviu Task",
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
        child: ListDataComponent<ReviewTaskModel>(
          controller: listController,
          enableDrag: false,
          enableGetMore: false,
          dataSource: (skip, search) {
            return ReviewTaskModel.get(
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
                  Text(
                    data?.assignKegiatan ?? "-",
                    style: System.data.textStyles!.basicLabel.copyWith(
                      color: System.data.color!.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total PKA: ${data?.jumlahProgram ?? "-"}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Text(
                    "Total KKA: ${data?.jumlahKertasKerja ?? "-"}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Text(
                    "Total Temuan: ${data?.jumlahTemuan ?? "-"}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Text(
                    "Total Rekomendasi: ${data?.jumlahRekomendasi ?? "-"}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reviu KaTim: ${data?.statusTemuan?.temuanKatim ?? "-"}",
                          style: System.data.textStyles!.basicLabel.copyWith(
                            color: System.data.color!.dangerColor,
                          ),
                        ),
                        Text(
                            "Reviu Manajer: ${data?.statusTemuan?.temuanManager ?? "-"}",
                            style: System.data.textStyles!.basicLabel.copyWith(
                              color: System.data.color!.warningColor,
                            )),
                        Text(
                          "Masuk LHA: ${data?.statusTemuan?.temuanLha ?? "-"}",
                          style: System.data.textStyles!.basicLabel.copyWith(
                            color: System.data.color!.infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "LHA",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "LHA Internal:",
                            style: System.data.textStyles!.basicLabel,
                            children: [
                              TextSpan(
                                text: " ${data?.statusLhaInternal ?? "-"}",
                                style:
                                    System.data.textStyles!.basicLabel.copyWith(
                                  color: getStatusColor(
                                    data?.statusLhaInternal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "LHA External:",
                            style: System.data.textStyles!.basicLabel,
                            children: [
                              TextSpan(
                                text: " ${data?.statusLhaEksternal ?? "-"}",
                                style:
                                    System.data.textStyles!.basicLabel.copyWith(
                                        color: getStatusColor(
                                  data?.statusLhaEksternal,
                                )),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Management Letter:",
                            style: System.data.textStyles!.basicLabel,
                            children: [
                              TextSpan(
                                text: " ${data?.statusManagementLetter ?? "-"}",
                                style:
                                    System.data.textStyles!.basicLabel.copyWith(
                                        color: getStatusColor(
                                  data?.statusManagementLetter,
                                )),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Audit Ratting:",
                            style: System.data.textStyles!.basicLabel,
                            children: [
                              TextSpan(
                                text: " ${data?.statusAuditRating ?? "-"}",
                                style:
                                    System.data.textStyles!.basicLabel.copyWith(
                                  color: getStatusColor(
                                    data?.statusAuditRating,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Tindak Lanjut",
                    style: System.data.textStyles!.basicLabel,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selesai: ${data?.statusTindakLanjut?.selesai ?? "-"}",
                          style: System.data.textStyles!.basicLabel.copyWith(
                            color: System.data.color!.infoColor,
                          ),
                        ),
                        Text(
                            "Belum Selesai: ${data?.statusTindakLanjut?.belumSelesai ?? "-"}",
                            style: System.data.textStyles!.basicLabel.copyWith(
                              color: System.data.color!.warningColor,
                            )),
                        Text(
                          "Belum Tindak Lanjut: ${data?.statusTindakLanjut?.belumTl ?? "-"}",
                          style: System.data.textStyles!.basicLabel.copyWith(
                            color: System.data.color!.dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "draf":
        return Colors.blue;
      case "revisi":
        return Colors.orange;
      case "final":
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
