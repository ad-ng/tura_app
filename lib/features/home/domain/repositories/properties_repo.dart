// import 'package:tura_app/features/register/data/model/registerModel.dart';
// import 'package:tura_app/features/login/data/models/user_model.dart';

// abstract class RegisterRepo {
//   Future<UserModel> signup(RegisterModel registerModel);
// }

import 'package:tura_app/features/home/data/models/properties_model.dart';

abstract class PropertiesRepo {
  Future<List<PropertiesModel>> fetchProps();

  Future<PropertiesModel> fetchSingleProp(String slug);
}
