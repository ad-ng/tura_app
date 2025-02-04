import 'package:tura_app/features/register/data/model/registerModel.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';

abstract class RegisterRepo {
  Future<UserModel> signup(RegisterModel registerModel);
}
