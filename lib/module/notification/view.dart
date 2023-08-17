import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/notification_model.dart';
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
          "Notifikasi",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return SizedBox(
      child: ListDataComponent<NotificationModel>(
        controller: ListDataComponentController<NotificationModel>(),
        enableGetMore: false,
        enableDrag: false,
        dataSource: (p0, p1) {
          return Future.value().then(
            (value) {
              return NotificationModel.dummy();
            },
          );
        },
        itemBuilder: (data, index) {
          return GestureDetector(
            onTap: (){
              widget.onTapNotification!.call(data);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data?.title ?? "",
                          style: System.data.textStyles!.boldTitleLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data?.body ?? "",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      ),
                    ],
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
