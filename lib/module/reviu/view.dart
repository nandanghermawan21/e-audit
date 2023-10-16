import 'package:eaudit/model/jumlah_reviu_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'view_model.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Daftar Reviu",
            style: System.data.textStyles!.boldTitleLightLabel,
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              color: Colors.transparent,
              child: YearModel.yearSelector(
                selectedYear: model.selectedYear,
                onChange: (val) {
                  model.selectedYear = val;
                  model.commit();
                },
              ),
            )
          ],
        ),
        body: Consumer<ViewModel>(
          builder: (c, d, w) {
            return body();
          },
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: FutureBuilder<JumlahReviuModel>(
          initialData: JumlahReviuModel(),
          future: JumlahReviuModel.get(
            token: System.data.global.token,
            tahun: model.selectedYear,
          ),
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (s.hasError) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: IntrinsicHeight(
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.exclamationTriangle,
                              color: Colors.red,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Terjadi kesalahan",
                              style: System.data.textStyles!.boldTitleLabel,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ErrorHandlingUtil.handleApiError(s.error),
                              style: System.data.textStyles!.basicLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      item(
                        label: "Reviu PKA",
                        value: s.data?.jumlahPKA,
                        onTap: (){
                          widget.onTapReviuPKA?.call(model.selectedYear);
                        },
                      ),
                      item(
                        label: "Reviu KKA",
                        value: s.data?.jumlahKKA,
                        onTap:  (){
                          widget.onTapReviuKKA?.call(model.selectedYear);
                        },
                      ),
                      item(
                        label: "Reviu KKPT",
                        value: s.data?.jumlahKKPT,
                        onTap: (){
                           widget.onTapReviuKKPT?.call(model.selectedYear);
                        },
                      ),
                      item(
                        label: "Reviu Tindak Lanjut",
                        value: s.data?.jumlahTL,
                        onTap: (){
                            widget.onTapReviuTindakLanjut?.call(model.selectedYear);
                        },
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }

  Widget item({
    VoidCallback? onTap,
    String? label,
    int? value,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: System.data.color!.background,
          border: Border.all(
            color: System.data.color!.darkBackgroundBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label ?? "",
                style: System.data.textStyles!.boldTitleLabel,
              ),
            ),
            CircleAvatar(
              backgroundColor: System.data.color!.primaryColor,
              maxRadius: 15,
              child: Text(
                value?.toString() ?? "",
                style: System.data.textStyles!.basicLightLabel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
