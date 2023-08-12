import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Kertas Kerja Audit",
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
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: ListDataComponent<AuditkaReviuModel>(
        controller: listController,
        enableGetMore: false,
        enableDrag: false,
        autoSearch: false,
        dataSource: (skip, key) {
          return Future.value().then(
            (value) {
              return [AuditkaReviuModel.dummy()];
            },
          );
        },
        itemBuilder: (data, index) {
          return Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                description(data),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Daftar Kertas Kerja Audit",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(data?.listKka?.length ?? 0, (index) {
                  return kkaItem(data, data?.listKka?[index]);
                })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget description(AuditkaReviuModel? data) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Obyek Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.objectAudit ?? "",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Auditor",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.auditor ?? "",
              style: System.data.textStyles!.basicLabel,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Judul Program",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.judulProgram ?? "",
              style: System.data.textStyles!.basicLabel,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Prosedur Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.proseduAudit ?? "",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget kkaItem(AuditkaReviuModel? data, AuditKKAModel? kka) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kka?.noKka ?? "",
                style: System.data.textStyles!.boldTitleLabel,
              ),
              Text(
                kka?.tanggal == null
                    ? ""
                    : DateFormat("dd MMMM yyyy").format(kka!.tanggal!),
                style: System.data.textStyles!.boldTitleLabel,
              ),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.grey.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Judul", style: System.data.textStyles!.boldTitleLabel),
              const SizedBox(
                height: 5,
              ),
              Text(
                kka?.judulKka ?? "",
                style: System.data.textStyles!.basicLabel,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status", style: System.data.textStyles!.boldTitleLabel),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    kka?.status ?? "",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Temuan", style: System.data.textStyles!.boldTitleLabel),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    kka?.temuan?.toString() ?? "",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aksi", style: System.data.textStyles!.boldTitleLabel),
              const SizedBox(
                height: 5,
              ),
              //buat outline dropdown
              Container(
                width: double.infinity,
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ActionModel>(
                    value: null,
                    items: List.generate(kka?.actions?.length ?? 0, (index) {
                      return DropdownMenuItem(
                        value: kka?.actions?[index],
                        child: Text(
                          kka?.actions?[index].label ?? "",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      );
                    }),
                    onChanged: (value) {
                      loadingController.stopLoading(
                        icon: const Icon(
                          FontAwesomeIcons.questionCircle,
                          color: Colors.orange,
                          size: 50,
                        ),
                        messageWidget: IntrinsicHeight(
                          child: Column(
                            children: [
                              Text(
                                "Anda Yakin Untuk ${value?.description} KKA?",
                                style: System.data.textStyles!.basicLabel,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loadingController.forceStop();
                                        kka?.action = value?.value;
                                        widget.onSelectAction!(
                                          AuditkaReviuModel(
                                            objectAudit: data?.objectAudit,
                                            judulProgram: data?.judulProgram,
                                            auditor: data?.auditor,
                                            proseduAudit: data?.proseduAudit,
                                            listKka: [kka],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Ya",
                                        style: System.data.textStyles!
                                            .boldTitleLightLabel,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loadingController.forceStop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.red.shade300,
                                        ),
                                      ),
                                      child: Text(
                                        "Tidak",
                                        style: System.data.textStyles!
                                            .boldTitleLightLabel,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
