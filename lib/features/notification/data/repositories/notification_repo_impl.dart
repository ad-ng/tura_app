import 'package:tura_app/features/notification/data/datasource/notificationApiService.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';
import 'package:tura_app/features/notification/domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationApiService _notificationApiService;

  NotificationRepoImpl(this._notificationApiService);

  @override
  Future<List<NotificationModel>> fetchAllNotifications() {
    return _notificationApiService.fetchAllNotifications();
  }
}
