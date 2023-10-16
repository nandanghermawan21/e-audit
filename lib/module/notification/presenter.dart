import 'package:eaudit/model/notification_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final ValueChanged<NotificationModel?>? onTapNotification;

  const Presenter({
    Key? key,
    this.view,
    this.onTapNotification,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getNotificationHistory();
  }

  Future<List<NotificationModel>?> getNotificationHistory() async {
    final List<ActiveNotification>? notificationHistory = await notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();

    await NotificationModel.getFromDb(
            db: System.data.database!.db!,
            userId: System.data.global.user?.userId)
        .then((value) {
      notificationHistory?.forEach(
        (element) async {
          if (value
                  ?.where(
                      (element2) => element2.notifId == element.id.toString())
                  .isEmpty ==
              true) {
            await NotificationModel(
              userId: System.data.global.user?.userId,
              notifId: element.id.toString(),
              title: element.title,
              body: element.body,
              dataId: element.payload,
              receivedDate: DateTime.now(),
            ).saveToDb(db: System.data.database!.db!).then(
                  (value) {},
                );
          }
        },
      );
    });

    return NotificationModel.getFromDb(
            db: System.data.database!.db!,
            userId: System.data.global.user?.userId)
        .then((value) {
      return value;
    });
  }
}
