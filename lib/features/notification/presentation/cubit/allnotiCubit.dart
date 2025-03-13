import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';
import 'package:tura_app/features/notification/domain/repositories/notification_repo.dart';

class AllNotiCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  AllNotiCubit(this._notificationRepo) : super(NotificationInitial()) {
    fetchAllNotifications();
  }

  Future fetchAllNotifications() async {
    emit(NotificationLoading());

    try {
      final response = await _notificationRepo.fetchAllNotifications();
      print('Fetched properties: $response'); // Log the response
      emit(NotificationSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(NotificationError(e.toString()));
    }
  }
}

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> response; // Response from the API
  NotificationSuccess(this.response);
}

class NotificationError extends NotificationState {
  final String message; // Error message
  NotificationError(this.message);
}
