import 'package:tura_app/features/register/data/datasources/registerApiService.dart';
import 'package:tura_app/features/register/data/model/registerModel.dart';
import 'package:tura_app/features/register/domain/repository/register_repo.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';

class RegisterRepoImpl implements RegisterRepo {
  final Registerapiservice _registerapiservice;

  RegisterRepoImpl(this._registerapiservice);

  @override
  Future<UserModel> signup(RegisterModel registerModel) async {
    return await _registerapiservice.signup(registerModel);
  }
}
