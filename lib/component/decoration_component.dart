import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DecorationComponent {
  static Widget buttonAction<T>({
    required CircularLoaderController loadingController,
    required ActionModel? action,
    required T? data,
    BoolBuilder? beforeAction,
    ValueChanged<T?>? onCofirmAction,
  }) {
    return GestureDetector(
      onTap: () {
        if (beforeAction != null) {
          if (beforeAction.call() == false) {
            return;
          }
        }
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
                  "Anda Yakin Untuk ${action?.description ?? action?.label}?",
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
                          onCofirmAction?.call(data);
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

  static Widget itemKomentar(KomentarModel komentar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                komentar.name ?? "",
                style: System.data.textStyles!.boldTitleLabel,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                komentar.tanggal == null
                    ? "-------"
                    : DateFormat("dd MMMM yyyy (hh:mm:ss)",
                            System.data.strings!.locale)
                        .format(
                        (komentar.tanggal!),
                      ),
                style: System.data.textStyles!.basicLabel,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            (komentar.komentar == null || komentar.komentar == "")
                ? "-------"
                : komentar.komentar ?? "",
            style: System.data.textStyles!.basicLabel,
          ),
        ],
      ),
    );
  }

  static Widget item({
    String? title = "",
    String? value = "",
    Widget? valueWidget,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                width: 100,
                child: Text(
                  title ?? "",
                  style: System.data.textStyles!.basicLabel,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                ":",
                style: System.data.textStyles!.basicLabel,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: valueWidget ??
                    Text(
                      value ?? "",
                      style: System.data.textStyles!.basicLabel.copyWith(
                        color: valueColor,
                      ),
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  static Widget itemColumn({
    String? title = "",
    String? value = "",
    Widget? valueWidget,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 100,
                  child: Text(
                    title ?? "",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  ":",
                  style: System.data.textStyles!.basicLabel,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            IntrinsicHeight(
              child: SizedBox(
                child: valueWidget ??
                    Text(
                      value ?? "",
                      style: System.data.textStyles!.basicLabel.copyWith(
                        color: valueColor,
                      ),
                    ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
