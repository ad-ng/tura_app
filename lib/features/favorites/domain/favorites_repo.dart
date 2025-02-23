import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';

abstract class FavoritesRepo {
  Future<List<Favoritesmodel?>> fetchAllFavorites();

  Future deleteFavorite(propertyId);

  Future<bool> checkFavorite(propertyId);

  Future addFavorite(propertyId, favoriteStatus);
}