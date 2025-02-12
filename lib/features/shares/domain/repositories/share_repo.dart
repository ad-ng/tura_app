import 'package:tura_app/features/shares/data/model/sharemodel.dart';

abstract class ShareRepo {
  Future<List<Sharemodel>> fetchSentShares();
}
