import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
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
          margin: const EdgeInsets.all(20),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                      widget.kkpt?.listKKPT?.first?.actions?.length ?? 0, (index) {
                    return Expanded(
                      child: DecorationComponent.buttonAction(
                        loadingController: loadingController,
                        action: widget.kkpt?.listKKPT?.first?.actions?[index],
                        data: widget.kkpt,
                        beforeAction: () {
                          if (catatanController.text == "") {
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
                              widget.kkpt?.listKKPT?.first?.actions?[index].value);
                        },
                      ),
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                      widget.kkpt?.listKKPT?.first?.actionsLHA?.length ?? 0, (index) {
                    return Expanded(
                      child: DecorationComponent.buttonAction(
                        loadingController: loadingController,
                        action: widget.kkpt?.listKKPT?.first?.actionsLHA?[index],
                        data: widget.kkpt,
                        onCofirmAction: (data) {
                          postReviuLha(
                              widget.kkpt?.listKKPT?.first?.actionsLHA?[index].value);
                        },
                      ),
                    );
                  }),
                ),
              ],
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
            description(widget.kkpt),
            const SizedBox(
              height: 20,
            ),
            Text("Reviu Temuan",
                style: System.data.textStyles!.boldTitleLabel.copyWith(
                  fontSize: 16,
                )),
            detailKKPT(widget.kkpt?.listKKPT?.first),
            const SizedBox(
              height: 20,
            ),
            Text("Komentar",
                style: System.data.textStyles!.boldTitleLabel.copyWith(
                  fontSize: 16,
                )),
            const SizedBox(
              height: 10,
            ),
            komentar(widget.kkpt?.listKKPT?.first?.komentar),
            const SizedBox(
              height: 20,
            ),
            (widget.kkpt?.listKKPT?.first?.actions?.length ?? 0) < 1
                ? const SizedBox()
                : catatan(),
          ],
        ),
      ),
    );
  }

  Widget description(AuditKKPTReviuModel? data) {
    return Column(
      children: [
        DecorationComponent.item(
          title: "Nama Kegiatan",
          value: data?.namakegiatan ?? "",
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
          title: "Tanggal Audit",
          value: data?.tanggalAudit == null
              ? "-"
              : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
                  (data!.tanggalAudit!),
                ),
        ),
        // DecorationComponent.item(
        //   title: "No KKA",
        //   value: data?.noKKa ?? "",
        // ),
        // DecorationComponent.item(
        //   title: "Bidang Subtansi",
        //   value: data?.bidangSubtansi ?? "",
        // ),
      ],
    );
  }

  Widget detailKKPT(AuditKKPTModel? data) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        DecorationComponent.item(
          title: "No Temuan",
          value: data?.noTemuan ?? "",
        ),
        DecorationComponent.item(
          title: "Judul Temuan",
          value: data?.judulTemuan ?? "",
        ),
        DecorationComponent.item(
          title: "Tanggal Temuan",
          value: data?.tanggalTemuan == null
              ? "-"
              : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
                  (data!.tanggalTemuan!),
                ),
        ),
        DecorationComponent.item(
          title: "Kriteria",
          valueWidget: Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Html(
                  data: data?.kriteria ?? "",
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
          ),
        ),
        DecorationComponent.item(
            title: "Sebab",
            valueWidget: Html(
              data: data?.sebab,
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
            )),
        DecorationComponent.item(
            title: "Akibat",
            valueWidget: Html(
              data: data?.akibat,
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
            )),
        DecorationComponent.item(
          title: "Lampiran",
          value: data?.namaLampiran ?? "",
          valueColor: System.data.color!.link,
          onTap: () {
            debugPrint("ontap sini");
            widget.onTapFile!(data?.namaLampiran, data?.lampiranUrl);
          },
        ),
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
        controller: catatanController,
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
