import 'package:tura_app/features/home/data/models/properties_model.dart';

abstract class PropertiesRepo {
  Future<List<PropertiesModel>> fetchProps(int page);

  Future<PropertiesModel> fetchSingleProp(String slug);

  Future<List<PropertiesModel>> filterProperties(int page);
}
