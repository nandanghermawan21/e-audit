import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:eaudit/module/auditKKPTReviu/view_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Temuan Audit",
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
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              loadingController.stopLoading(
                message: "Data Berhasil Tersimpan",
                isError: false,
                duration: const Duration(seconds: 3),
                onCloseCallBack: () {
                  widget.onSubmitSuccess!();
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                System.data.color!.primaryColor,
              ),
            ),
            child: Text(
              "Simpan",
              style: System.data.textStyles!.boldTitleLightLabel,
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return ChangeNotifierProvider.value(
      value: model,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              description(widget.kkpt),
              const SizedBox(
                height: 20,
              ),
              Text("Reviu Temuan",
                  style: System.data.textStyles!.boldTitleLabel.copyWith(
                    fontSize: 16,
                  )),
              detailKKPT(widget.kkpt?.listKKPT?.first),
            ],
          ),
        ),
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

  Widget detailKKPT(AuditKKPTModel? data) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        detail(
          label: "No Temuan",
          value: data?.noTemuan ?? "",
        ),
        detail(
          label: "Judul Temuan",
          value: data?.judulTemuan ?? "",
        ),
        detail(
          label: "Tanggal Temuan",
          value: data?.tanggalTemuan == null
              ? "-"
              : DateFormat("dd MMMM yyyy").format(
                  (data!.tanggalTemuan!),
                ),
        ),
        detail(
          label: "Kriteria",
          value: data?.kriteria ?? "",
        ),
        detail(
          label: "Sebab",
          value: data?.sebab ?? "",
        ),
        detail(
          label: "Akibat",
          value: data?.akibat ?? "",
        ),
        detail(
          label: "Lampirn",
          value: data?.namaLampiran ?? "",
          valueColor: System.data.color!.link,
          onTap: () {
            debugPrint("ontap sini");
            widget.onTapFile!(data?.namaLampiran, data?.lampiranUrl);
          },
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
                "Komentar",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: List.generate(data?.komentar?.length ?? 0, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data?.komentar?[index].name ?? "",
                              style: System.data.textStyles!.boldTitleLabel,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data?.komentar?[index].tanggal == null
                                  ? "-"
                                  : DateFormat("dd MMMM yyyy").format(
                                      (data?.komentar?[index].tanggal!)!,
                                    ),
                              style: System.data.textStyles!.basicLabel,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          data?.komentar?[index].komentar ?? "",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: (val) {
              // data?.catatan = val;
              // listController.commit();
            },
            maxLines: 5,
            decoration: InputDecoration.collapsed(
              hintText: "Catatan",
              hintStyle: System.data.textStyles!.basicLabel,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Consumer<ViewMOdel>(
                builder: (c, d, w) {
                  return Checkbox(
                    value: data?.masukLha ?? false,
                    onChanged: (val) {
                      data?.masukLha = val ?? false;
                      model.commit();
                    },
                  );
                },
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "Masuk LHA",
                  style: System.data.textStyles!.basicLabel,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget detail({
    String? label,
    String? value,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
                  style: System.data.textStyles!.basicLabel.copyWith(
                    color: valueColor,
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
