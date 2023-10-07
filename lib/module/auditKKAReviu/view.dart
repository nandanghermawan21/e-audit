import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:eaudit/component/decoration_component.dart';

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
            "Reviu Kertas Kerja Audit",
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
                widget.kka?.listKka?.first?.actions?.length ?? 0, (index) {
              return Expanded(
                child: DecorationComponent.buttonAction(
                  loadingController: loadingController,
                  action: widget.kka?.listKka?.first?.actions?[index],
                  data: widget.kka,
                  onCofirmAction: (data) {
                    widget.onSubmitSuccess?.call();
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            description(widget.kka),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Reviu Kertas Kerja",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            kertasKerja(widget.kka?.listKka?.first),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Komentar",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            komentar(widget.kka?.listKka?.first?.komentar),
            const SizedBox(
              height: 20,
            ),
            catatan(),
          ],
        ),
      ),
    );
  }

  Widget description(AuditkaReviuModel? data) {
    return Column(
      children: [
        DecorationComponent.item(
          title: "Kegiatan",
          value: data?.kegiatan ?? "",
        ),
        DecorationComponent.item(
          title: "Auditee",
          value: data?.auditee ?? "",
        ),
        DecorationComponent.item(
          title: "Tipe Audit",
          value: data?.tipeAudit ?? "",
        ),
        DecorationComponent.item(
            title: "Tanggal",
            value:
                "${data?.startDate == null ? "-" : DateFormat("dd MMMM yyyy", "id_ID").format(data!.startDate!)} s/d ${data?.endDate == null ? "-" : DateFormat("dd MMMM yyyy", "id_ID").format(data!.endDate!)}"),
      ],
    );
  }

  Widget komentar(List<KomentarModel?>? data) {
    return SizedBox(
      child: (data?.length ?? 0) > 0
          ? Column(
              children: List.generate(data?.length ?? 0, (index) {
                return DecorationComponent.itemKomentar((data![index]!));
              }),
            )
          : Text("Tidak ada komentar",
              style: System.data.textStyles!.basicLabel),
    );
  }

  Widget catatan() {
    return Container(
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
    );
  }

  Widget kertasKerja(AuditKKAModel? data) {
    return Column(
      children: [
        DecorationComponent.item(
          title: "Nomor KKA",
          value: data?.noKka ?? "",
        ),
        DecorationComponent.item(
          title: "Judul KKA",
          value: data?.judulKka ?? "",
        ),
        DecorationComponent.item(
          title: "Dokumen yang diperiksa",
          value: data?.dokumenYangDiperiksa ?? "",
        ),
        DecorationComponent.item(
          title: "Tanggal KKA",
          value: data?.tanggal == null
              ? "-"
              : DateFormat("dd MMMM yyyy").format(data!.tanggal!),
        ),
        DecorationComponent.item(
            title: "Uraian",
            valueWidget: Center(child: Html(data: data?.uraian))),
        DecorationComponent.item(
            title: "Kesimpulan",
            valueWidget: Center(child: Html(data: data?.kesimpulan))),
        DecorationComponent.item(
          title: "File Kertas Kerja",
          // value: data?.fileKertasKerja ?? "",
          valueWidget: GestureDetector(
            onTap: () {
              widget.onTapDocument?.call(
                  data?.fileKertasKerja ?? "", data?.urlFileKertasKerja ?? "");
            },
            child: Text(
              data?.fileKertasKerja ?? "",
              style: System.data.textStyles!.basicLabel.copyWith(
                color: System.data.color!.link,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
