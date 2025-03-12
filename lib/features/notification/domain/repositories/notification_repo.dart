import 'package:tura_app/features/notification/data/model/notificationModel.dart';

abstract class NotificationRepo {
  Future<List<NotificationModel>> fetchAllNotifications();
  Future<List<NotificationModel>> fetchUnreadNotifications();
}
