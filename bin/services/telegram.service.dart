import 'package:get_it/get_it.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/teledart.dart';

import 'config.service.dart';

class TelegramService {
  late Telegram telegram;
  late TeleDart teledart;

  TelegramService() {
    final config = GetIt.I.get<ConfigService>();

    telegram = Telegram(config.get<String>('apiToken'));
    teledart = TeleDart(telegram, Event());

    teledart.start().then((me) => print('${me.username} is initialised'));
  }
}
