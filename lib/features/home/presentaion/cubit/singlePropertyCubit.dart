import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/domain/repositories/properties_repo.dart';

class SinglePropertyCubit extends Cubit<PropertyState> {
  final PropertiesRepo _propertiesRepo;

  SinglePropertyCubit(this._propertiesRepo) : super(PropertiesInitial());

  Future fetchSingleProps(String slug) async {
    emit(PropertiesLoading());

    try {
      final response = await _propertiesRepo.fetchSingleProp(slug);
      print('Fetched properties: $response');
      emit(PropertySuccess(response));
    } catch (e) {
      print('Error fetching properties: $e');
      emit(PropertyError(e.toString()));
    }
  }
}

abstract class PropertyState {}

class PropertiesInitial extends PropertyState {}

class PropertiesLoading extends PropertyState {}

class PropertySuccess extends PropertyState {
  final PropertiesModel response; // Response from the API
  PropertySuccess(this.response);
}

class PropertyError extends PropertyState {
  final String message; // Error message
  PropertyError(this.message);
}
