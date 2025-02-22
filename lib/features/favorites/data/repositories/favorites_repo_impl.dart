import 'package:tura_app/features/favorites/data/datasources/favoritesApiService.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/features/favorites/domain/favorites_repo.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final Favoritesapiservice _favoritesapiservice;

  FavoritesRepoImpl(this._favoritesapiservice);

  @override
  Future<List<Favoritesmodel>> fetchAllFavorites() async {
    return await _favoritesapiservice.fetchAllFavorites();
  }
}
