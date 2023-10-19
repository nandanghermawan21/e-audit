import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_notifikasi_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      cover: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Notifikasi",
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
        body: widget.openNotification == null ? body() : const SizedBox(),
      ),
    );
  }

  Widget body() {
    return SizedBox(
      child: ListDataComponent<AuditNotificationModel>(
        controller: listDataComponentController,
        canRefresh: true,
        enableDrag: false,
        enableGetMore: false,
        dataSource: (skip, key) {
          return AuditNotificationModel.get(
            token: System.data.global.token,
          );
        },
        itemBuilder: (data, index) {
          return GestureDetector(
            onTap: () {
              openNotification(data);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ],
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data?.auditeeName ?? "",
                        style: System.data.textStyles!.boldTitleLabel.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        data?.notificationTime == null
                            ? "-"
                            : DateFormat("dd MMMM yyyy HH:mm")
                                .format(data!.notificationTime!),
                        style:
                            System.data.textStyles!.boldTitleLabel.copyWith(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data?.senderName ?? "",
                        style: System.data.textStyles!.basicLabel.copyWith(),
                      ),
                      Text(
                        data?.typeTitle ?? "",
                        style: System.data.textStyles!.basicLabel.copyWith(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data?.notificationMessage ?? "",
                    style: System.data.textStyles!.basicLabel.copyWith(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
