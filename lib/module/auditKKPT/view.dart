import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
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
      child: ListDataComponent<AuditKKPTReviuModel>(
        controller: listController,
        enableGetMore: false,
        enableDrag: false,
        autoSearch: false,
        dataSource: (skip, key) {
          return Future.value().then(
            (value) {
              return [AuditKKPTReviuModel.dummy()];
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
                ...List.generate(data?.listKKPT?.length ?? 0, (index) {
                  return kkptItem(data, data?.listKKPT?[index]);
                })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget description(AuditKKPTReviuModel? data) {
    return Column(
      children: [
        detail(
          label: "Nama Kegiatan",
          value: data?.namakegiatan ?? "",
        ),
        detail(
          label: "Auditee",
          value: data?.auditee ?? "",
        ),
        detail(
          label: "Tipe Audit",
          value: data?.tipeAudit ?? "",
        ),
        detail(
          label: "Tanggal Audit",
          value: data?.tanggalAudit == null
              ? "-"
              : DateFormat("dd MMMM yyyy").format(
                  (data!.tanggalAudit!),
                ),
        ),
        detail(
          label: "No KKA",
          value: data?.noKKa ?? "",
        ),
        detail(
          label: "Bidang Subtansi",
          value: data?.bidangSubtansi ?? "",
        ),
      ],
    );
  }

  Widget kkptItem(AuditKKPTReviuModel? data, AuditKKPTModel? kkpt) {
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
                kkpt?.judulTemuan ?? "",
                style: System.data.textStyles!.boldTitleLabel,
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
                    kkpt?.status ?? "",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Rekomendasi",
                      style: System.data.textStyles!.boldTitleLabel),
                  const SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    radius: 15,
                    child: Text(
                      kkpt?.rekomendasi?.toString() ?? "",
                      style: System.data.textStyles!.basicLightLabel,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              kkpt?.actions.length ?? 0,
              (index) {
                return buttonAction(
                  action: kkpt?.actions[index],
                  data: data,
                  kkpt: kkpt,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buttonAction({
    required ActionModel? action,
    required AuditKKPTReviuModel? data,
    required AuditKKPTModel? kkpt,
  }) {
    return GestureDetector(
      onTap: () {
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
                  "Anda Yakin Untuk ${action?.description} KKPT?",
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
                          widget.onSelectAction!(
                            AuditKKPTReviuModel(
                                id: data?.id,
                                auditee: data?.auditee,
                                bidangSubtansi: data?.bidangSubtansi,
                                namakegiatan: data?.namakegiatan,
                                noKKa: data?.noKKa,
                                tipeAudit: data?.tipeAudit,
                                tanggalAudit: data?.tanggalAudit,
                                listKKPT: [kkpt]),
                          );
                        },
                        child: Text(
                          "Ya",
                          style: System.data.textStyles!.boldTitleLightLabel,
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
                          backgroundColor: MaterialStateProperty.all(
                            Colors.red.shade300,
                          ),
                        ),
                        child: Text(
                          "Tidak",
                          style: System.data.textStyles!.boldTitleLightLabel,
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
      child: Container(
        height: 40,
        width: 100,
        margin: const EdgeInsets.only(left: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: action?.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          action?.label ?? "",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
      ),
    );
  }

  Widget detail({
    String? label,
    String? value,
  }) {
    return Column(
      children: [
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
                label ?? "",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                value ?? "",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
