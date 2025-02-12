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
}
