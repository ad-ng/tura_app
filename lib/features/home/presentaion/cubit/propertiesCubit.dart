
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/domain/repositories/properties_repo.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  final PropertiesRepo _propertiesRepo;

  PropertiesCubit(this._propertiesRepo) : super(PropertiesInitial()) {
    fetchProps(1);
  }

  Future fetchProps(int page) async {
    emit(PropertiesLoading());

    try {
      final response = await _propertiesRepo.fetchProps(page);
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
