import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';
import 'package:tura_app/features/notification/domain/repositories/notification_repo.dart';

class UnreadCubit extends Cubit<UnreadNotificationState> {
  final NotificationRepo _notificationRepo;
  UnreadCubit(this._notificationRepo) : super(UnreadNotificationInitial()) {
    fetchUnreadNotifications();
  }

  Future fetchUnreadNotifications() async {
    emit(UnreadNotificationLoading());

    try {
      final response = await _notificationRepo.fetchUnreadNotifications();
      print('Fetched properties: $response'); // Log the response
      emit(UnreadNotificationSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(UnreadNotificationError(e.toString()));
    }
  }
}

abstract class UnreadNotificationState {}

class UnreadNotificationInitial extends UnreadNotificationState {}

class UnreadNotificationLoading extends UnreadNotificationState {}

class UnreadNotificationSuccess extends UnreadNotificationState {
  final List<NotificationModel> response; // Response from the API
  UnreadNotificationSuccess(this.response);
}

class UnreadNotificationError extends UnreadNotificationState {
  final String message; // Error message
  UnreadNotificationError(this.message);
}
