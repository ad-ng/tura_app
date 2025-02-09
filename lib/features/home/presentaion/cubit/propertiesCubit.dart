// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tura_app/features/register/data/model/registerModel.dart';
// import 'package:tura_app/features/register/domain/repository/register_repo.dart';

// class Registercubit extends Cubit<RegisterState> {
//   final RegisterRepo _registerRepo;
//   Registercubit(this._registerRepo) : super(RegisterInitial());

//   Future signup(RegisterModel registerModel) async {
//     emit(RegisterLoading()); // Emit loading state

//     try {
//       // Call the login method from the repository
//       final response = await _registerRepo.signup(registerModel);

//       // Emit success state with the response
//       emit(RegisterSuccess(response));
//     } catch (e) {
//       // Emit error state with the error message
//       emit(RegisterError(e.toString()));
//     }
//   }
// }

// // States for LoginCubit
// abstract class RegisterState {}

// class RegisterInitial extends RegisterState {}

// class RegisterLoading extends RegisterState {}

// class RegisterSuccess extends RegisterState {
//   final dynamic response; // Response from the API
//   RegisterSuccess(this.response);
// }

// class RegisterError extends RegisterState {
//   final String message; // Error message
//   RegisterError(this.message);
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/domain/repositories/properties_repo.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  final PropertiesRepo _propertiesRepo;

  PropertiesCubit(this._propertiesRepo) : super(PropertiesInitial()) {
    fetchProps();
  }

  Future fetchProps() async {
    emit(PropertiesLoading());

    try {
      final response = await _propertiesRepo.fetchProps();
      print('Fetched properties: $response'); // Log the response
      emit(PropertiesSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(PropertiesError(e.toString()));
    }
  }
}

abstract class PropertiesState {}

class PropertiesInitial extends PropertiesState {}

class PropertiesLoading extends PropertiesState {}

class PropertiesSuccess extends PropertiesState {
  final List<PropertiesModel> response; // Response from the API
  PropertiesSuccess(this.response);
}

class PropertiesError extends PropertiesState {
  final String message; // Error message
  PropertiesError(this.message);
}
