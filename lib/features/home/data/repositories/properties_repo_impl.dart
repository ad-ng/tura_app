// class RegisterRepoImpl implements RegisterRepo {
//   final Registerapiservice _registerapiservice;

//   RegisterRepoImpl(this._registerapiservice);

//   @override
//   Future<UserModel> signup(RegisterModel registerModel) async {
//     return await _registerapiservice.signup(registerModel);
//   }
// }

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
  Future<List<PropertiesModel>> filterProperties(
      bool isForSale, String price, String size, bool isForRent) async {
    return await _propertiesapiservice.filterProperties(
        isForSale, price, size, isForRent);
  }
}
