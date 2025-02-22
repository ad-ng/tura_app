import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/features/favorites/domain/favorites_repo.dart';

class Favoritescubit extends Cubit<FavoritesState> {
  final FavoritesRepo _favoritesRepo;

  Favoritescubit(this._favoritesRepo) : super(FavoriteInitial()) {
    fetchAllFavorites();
  }

  Future<List<Favoritesmodel>> fetchAllFavorites() async {
    return await _favoritesRepo.fetchAllFavorites();
  }
}

abstract class FavoritesState {}

class FavoriteInitial extends FavoritesState {}

class FavoriteLoading extends FavoritesState {}

class FavoriteSuccess extends FavoritesState {
  final List<Favoritesmodel> response; // Response from the API
  FavoriteSuccess(this.response);
}

class FavoriteError extends FavoritesState {
  final String message; // Error message
  FavoriteError(this.message);
}
