import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/profile/data/datasources/remote/userapiservice.dart';
import 'package:tura_app/features/profile/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserApiService _userApiService;

  UserRepoImpl(this._userApiService);

  @override
  Future<UserModel> fetchUser() {
    return _userApiService.fetchUserByUsername();
  }
}
