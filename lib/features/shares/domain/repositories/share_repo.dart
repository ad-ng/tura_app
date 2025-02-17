import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';

abstract class ShareRepo {
Future<List<Sharemodel>> fetchSentShares();
Future<List<Sharemodel>> fetchSharesReceived();
Future<List<UserModel>> searchFilterUsers(String query);
Future <String?> createShare(int propertyId, int recipientId);
}

