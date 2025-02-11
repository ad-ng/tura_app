import 'package:tura_app/features/login/data/models/user_model.dart';

abstract class UserRepo {
  Future<UserModel> fetchUser();
}