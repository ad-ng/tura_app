import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/domain/repositories/properties_repo.dart';

class PropertiesRepoImpl implements PropertiesRepo {
  final PropertiesApiService _propertiesapiservice;

  PropertiesRepoImpl(this._propertiesapiservice);

  @override
  Future<List<PropertiesModel>> fetchProps(int page) async {
    return await _propertiesapiservice.fetchProps(page);
  }

  @override
  Future<PropertiesModel> fetchSingleProp(String slug) async {
    return await _propertiesapiservice.fetchSingleProp(slug);
  }

  @override
  Future<List<PropertiesModel>> filterProperties(int page)async{
    return await _propertiesapiservice.filterProperties(page);
  }
}
