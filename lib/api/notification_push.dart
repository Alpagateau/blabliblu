import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_application_1/api/utilities.dart';

Future<void> createPlantFoodNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock.',
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
