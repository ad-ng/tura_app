import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';

abstract class FavoritesRepo {
  Future<List<Favoritesmodel>> fetchAllFavorites();
}