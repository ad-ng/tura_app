import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/domain/repositories/share_repo.dart';

class SharesSentCubit extends Cubit<SharesSentState> {
  final ShareRepo _shareRepo;

  SharesSentCubit(this._shareRepo) : super(SharesSentInitial()) {
    fetchSharesSent();
  }

  Future fetchSharesSent() async {
    emit(SharesSentLoading());

    try {
      final response = await _shareRepo.fetchSentShares();
      print('Fetched user: $response'); // Log the response
      emit(SharesSentSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(SharesSentError(e.toString()));
    }
  }
}

abstract class SharesSentState {}

class SharesSentInitial extends SharesSentState {}

class SharesSentLoading extends SharesSentState {}

class SharesSentSuccess extends SharesSentState {
  final List <Sharemodel> response; // Response from the API
  SharesSentSuccess(this.response);
}

class SharesSentError extends SharesSentState {
  final String message; // Error message
  SharesSentError(this.message);
}
