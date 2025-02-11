import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/profile/domain/repository/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo _userRepo;

  UserCubit(this._userRepo) : super(UserInitial()) {
    fetchUser();
  }

  Future fetchUser() async {
    emit(UserLoading());

    try {
      final response = await _userRepo.fetchUser();
      print('Fetched user: $response'); // Log the response
      emit(UserSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(UserError(e.toString()));
    }
  }
}

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel response; // Response from the API
  UserSuccess(this.response);
}

class UserError extends UserState {
  final String message; // Error message
  UserError(this.message);
}
