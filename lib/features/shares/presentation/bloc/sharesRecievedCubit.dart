import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/domain/repositories/share_repo.dart';

class SharesrecievedCubit extends Cubit<SharesRecievedState> {
  final ShareRepo _shareRepo;

  SharesrecievedCubit(this._shareRepo) : super(SharesRecievedInitial()) {
    fetchSharesReceived();
  }

  Future fetchSharesReceived() async {
    emit(SharesRecievedLoading());

    try {
      final response = await _shareRepo.fetchSharesReceived();
      print('Fetched user: $response'); // Log the response
      emit(SharesRecievedSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(SharesRecievedError(e.toString()));
    }
  }
}

abstract class SharesRecievedState {}

class SharesRecievedInitial extends SharesRecievedState {}

class SharesRecievedLoading extends SharesRecievedState {}

class SharesRecievedSuccess extends SharesRecievedState {
  final List<Sharemodel> response; // Response from the API
  SharesRecievedSuccess(this.response);
}

class SharesRecievedError extends SharesRecievedState {
  final String message; // Error message
  SharesRecievedError(this.message);
}
