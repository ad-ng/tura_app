import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/domain/repositories/share_repo.dart';

class CreateShareCubit extends Cubit<CreateShareState> {
  final ShareRepo _shareRepo;

  CreateShareCubit(this._shareRepo) : super(CreateShareInitial());

  Future createShare(int propertyId, int recipientId) async {
    emit(CreateShareLoading());

    try {
      final response = await _shareRepo.createShare(propertyId, recipientId);
      print('Fetched user: $response'); // Log the response
      emit(CreateShareSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(CreateShareError(e.toString()));
    }
  }
}

abstract class CreateShareState {}

class CreateShareInitial extends CreateShareState {}

class CreateShareLoading extends CreateShareState {}

class CreateShareSuccess extends CreateShareState {
  final String response; // Response from the API
  CreateShareSuccess(this.response);
}

class CreateShareError extends CreateShareState {
  final String message; // Error message
  CreateShareError(this.message);
}
