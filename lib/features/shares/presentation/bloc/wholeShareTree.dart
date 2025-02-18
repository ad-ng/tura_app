import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/domain/repositories/share_repo.dart';

class Wholesharetree extends Cubit<WholesharetreeState> {
  final ShareRepo _shareRepo;

  Wholesharetree(this._shareRepo) : super(WholesharetreeInitial());

  Future fetchShareTree(int shareId) async {
    emit(WholesharetreeLoading());

    try {
      final response = await _shareRepo.fetchShareTree(shareId);
      print('Fetched user: $response'); // Log the response
      emit(WholesharetreeSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(WholesharetreeError(e.toString()));
    }
  }
}

abstract class WholesharetreeState {}

class WholesharetreeInitial extends WholesharetreeState {}

class WholesharetreeLoading extends WholesharetreeState {}

class WholesharetreeSuccess extends WholesharetreeState {
  final List<Sharemodel> response; // Response from the API
  WholesharetreeSuccess(this.response);
}

class WholesharetreeError extends WholesharetreeState {
  final String message; // Error message
  WholesharetreeError(this.message);
}
