import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'config.service.dart';

class MongoService {
  late final Db db;

  MongoService() {
    final config = GetIt.I.get<ConfigService>();
    db = Db(config.get('mongo.url'));
  }
}
