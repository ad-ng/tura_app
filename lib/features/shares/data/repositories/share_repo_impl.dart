import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/shares/data/datasources/shareapiservice.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/domain/repositories/share_repo.dart';

class ShareRepoImpl implements ShareRepo {
  final ShareApiService _shareApiService;
  ShareRepoImpl(this._shareApiService);
  @override
  Future<List<Sharemodel>> fetchSentShares() async {
    return await _shareApiService.fetchSentShares();
  }

  @override
  Future<List<Sharemodel>> fetchSharesReceived() async {
    return await _shareApiService.fetchSharesReceived();
  }

  @override
  Future<List<UserModel>> searchFilterUsers(String query) async {
    final users = await _shareApiService.fetchAllUsers();
    return users.where((user) {
      final fullNameLower = user.fullname!.toLowerCase();
      final userNameLower = user.username!.toLowerCase();
      final searchLower = query.toLowerCase();

      return fullNameLower.contains(searchLower) ||
          userNameLower.contains(searchLower);
    }).toList();
  }

  @override
  Future<String?> createShare(int propertyId, int recipientId) async {
    return await _shareApiService.createShare(propertyId, recipientId);
  }

  @override
  Future<List<Sharemodel>> fetchShareTree(int shareId) async {
    return await _shareApiService.fetchShareTree(shareId);
  }
}
