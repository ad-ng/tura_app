import 'package:tura_app/features/favorites/data/datasources/favoritesApiService.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/features/favorites/domain/favorites_repo.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final Favoritesapiservice _favoritesapiservice;

  FavoritesRepoImpl(this._favoritesapiservice);

  @override
  Future<List<Favoritesmodel?>> fetchAllFavorites() async {
    return await _favoritesapiservice.fetchAllFavorites();
  }

  @override
  Future addFavorite(propertyId, favoriteStatus) async {
    return await _favoritesapiservice.addFavorite(propertyId, favoriteStatus);
  }

  @override
  Future<bool> checkFavorite(propertyId) async {
    return await _favoritesapiservice.checkFavorite(propertyId);
  }

  @override
  Future deleteFavorite(propertyId) async {
    return await _favoritesapiservice.deleteFavorite(propertyId);
  }
}
