import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/favorites/domain/favorites_repo.dart';

class FavoriteServicecubit extends Cubit<FavoriteServiceState> {
  final FavoritesRepo _FavoritesRepo;

  FavoriteServicecubit(this._FavoritesRepo) : super(FavoriteServiceInitial()) {
    fetchProps();
  }

  Future fetchProps() async {
    emit(FavoriteServiceLoading());

    try {
      final response = await _FavoritesRepo.fetchAllFavorites();
      print('Fetched properties: $response'); // Log the response
      emit(FavoriteServiceSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(FavoriteServiceError(e.toString()));
    }
  }
}

abstract class FavoriteServiceState {}

class FavoriteServiceInitial extends FavoriteServiceState {}

class FavoriteServiceLoading extends FavoriteServiceState {}

class FavoriteServiceSuccess extends FavoriteServiceState {
  final response; // Response from the API
  FavoriteServiceSuccess(this.response);
}

class FavoriteServiceError extends FavoriteServiceState {
  final String message; // Error message
  FavoriteServiceError(this.message);
}
