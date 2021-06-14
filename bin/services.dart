import 'package:get_it/get_it.dart';

import 'services/config.service.dart';
import 'services/mongo.service.dart';
import 'services/scheduler.service.dart';
import 'services/telegram.service.dart';

class Services {
  static void setup() {
    GetIt.I.registerSingleton<ConfigService>(ConfigService());
    GetIt.I.registerSingleton<MongoService>(MongoService());
    GetIt.I.registerSingleton<TelegramService>(TelegramService());
    GetIt.I.registerSingleton<SchedulerService>(SchedulerService());
  }
}
