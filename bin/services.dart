import 'package:get_it/get_it.dart';

import 'common/services/config.service.dart';
import 'common/services/mongo.service.dart';
import 'commands/scheduler/scheduler.service.dart';
import 'common/services/telegram.service.dart';

class Services {
  static void setup() {
    GetIt.I.registerSingleton<ConfigService>(ConfigService());
    GetIt.I.registerSingleton<MongoService>(MongoService());
    GetIt.I.registerSingleton<TelegramService>(TelegramService());
    GetIt.I.registerSingleton<SchedulerService>(SchedulerService());
  }
}
