import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/models/login_model.dart';
import 'package:tura_app/repos/logIn_repo.dart';
 
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  // Method to handle login
  Future<void> login(String username, String password) async {
    emit(LoginLoading()); // Emit loading state

    try {
      // Create a LoginModel instance
      final loginModel = LoginModel(username: username, password: password);

      // Call the login method from the repository
      final response = await _loginRepository.login(loginModel);

      // Emit success state with the response
      emit(LoginSuccess(response));
    } catch (e) {
      // Emit error state with the error message
      emit(LoginError(e.toString()));
    }
  }
}

// States for LoginCubit
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final dynamic response; // Response from the API
  LoginSuccess(this.response);
}

class LoginError extends LoginState {
  final String message; // Error message
  LoginError(this.message);
}
