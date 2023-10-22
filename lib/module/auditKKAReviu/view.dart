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
          margin: const EdgeInsets.all(20),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                  widget.kka?.listKka?.first?.actions?.length ?? 0, (index) {
                return Expanded(
                  child: DecorationComponent.buttonAction(
                    loadingController: loadingController,
                    action: widget.kka?.listKka?.first?.actions?[index],
                    data: widget.kka,
                    beforeAction: () {
                      if (noteController.text == "") {
                        loadingController.stopLoading(
                          message: "Catatan tidak boleh kosong",
                          isError: true,
                        );
                        return false;
                      } else {
                        return true;
                      }
                    },
                    onCofirmAction: (data) {
                      postReviu(
                          widget.kka?.listKka?.first?.actions?[index].value);
                    },
                  ),
                );
              }),
            ),
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
            (widget.kka?.listKka?.first?.actions?.length ?? 0) == 0
                ? const SizedBox()
                : catatan(),
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
                "${data?.startDate == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(data!.startDate!)} s/d ${data?.endDate == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(data!.endDate!)}"),
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
        controller: noteController,
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
          title: "Judul Program",
          value: data?.judulProgram ?? "",
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
              : DateFormat("dd MMMM yyyy", System.data.strings!.locale)
                  .format(data!.tanggal!),
        ),
        DecorationComponent.item(
          title: "Uraian",
          valueWidget: Center( //horizonal scroll
            child: Html(
              data: data?.uraian,
              shrinkWrap: true,
              style: {
                "body": Style(
                  fontSize: const FontSize(17),
                  fontFamily: System.data.font!.primary,
                ),
                "*": Style(
                  fontSize: const FontSize(17),
                  fontFamily: System.data.font!.primary,
                ),
              },
            ),
          ),
        ),
        DecorationComponent.item(
            title: "Kesimpulan",
            valueWidget: Center(
                child: Html(
              data: data?.kesimpulan,
              shrinkWrap: true,
              style: {
                "body": Style(
                  fontSize: const FontSize(17),
                  fontFamily: System.data.font!.primary,
                ),
                "*": Style(
                  fontSize: const FontSize(17),
                  fontFamily: System.data.font!.primary,
                ),
              },
            ))),
        DecorationComponent.item(
          title: "File Kertas Kerja",
          // value: data?.fileKertasKerja ?? "",
          valueWidget: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                data?.lampiran?.length ?? 0,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTapDocument?.call(
                          data?.lampiran?[index]?.name ?? "",
                          data?.lampiran?[index]?.url ?? "");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        data?.lampiran?[index]?.name ?? "",
                        style: System.data.textStyles!.basicLabel.copyWith(
                          color: System.data.color!.primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
