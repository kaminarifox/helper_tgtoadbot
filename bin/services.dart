import 'package:get_it/get_it.dart';

import 'services/config.service.dart';
import 'services/telegram.service.dart';

class Services {

  static void setup() {
    GetIt.I.registerSingleton<ConfigService>(ConfigService());
    GetIt.I.registerSingleton<TelegramService>(TelegramService());
  }
}
