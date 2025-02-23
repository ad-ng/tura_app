import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/features/favorites/domain/favorites_repo.dart';

class Favoritescubit extends Cubit<favoriteState> {
  final FavoritesRepo _FavoritesRepo;

  Favoritescubit(this._FavoritesRepo) : super(FavoriteInitial()) {
    fetchProps();
  }

  Future fetchProps() async {
    emit(FavoriteLoading());

    try {
      final response = await _FavoritesRepo.fetchAllFavorites();
      print('Fetched properties: $response'); // Log the response
      emit(FavoriteSuccess(response));
    } catch (e) {
      print('Error fetching properties: $e'); // Log any error
      emit(FavoriteError(e.toString()));
    }
  }
}

abstract class favoriteState {}

class FavoriteInitial extends favoriteState {}

class FavoriteLoading extends favoriteState {}

class FavoriteSuccess extends favoriteState {
  final List<Favoritesmodel?> response; // Response from the API
  FavoriteSuccess(this.response);
}

class FavoriteError extends favoriteState {
  final String message; // Error message
  FavoriteError(this.message);
}
