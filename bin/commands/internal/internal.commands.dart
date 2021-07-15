import 'package:get_it/get_it.dart';
import '../../common/services/telegram.service.dart';
import 'internal_commands_handlers.dart';

class InternalCommands {
  InternalCommands() {
    final bot = GetIt.I.get<TelegramService>();

    bot.teledart.onCommand('prime_on').listen(prime_on);
    bot.teledart.onCommand('prime_off').listen(prime_off);
  }
}
