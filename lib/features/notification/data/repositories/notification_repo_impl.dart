import 'package:tura_app/features/notification/data/datasource/notificationApiService.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';
import 'package:tura_app/features/notification/domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  @override
  Future<List<NotificationModel>> fetchAllNotifications() {
    return NotificationApiService().fetchAllNotifications();
  }
}
