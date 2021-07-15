import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:intl/intl.dart';

import '../../common/services/config.service.dart';
import '../../common/services/telegram.service.dart';
import 'scheduler.service.dart';
import 'scheduler_types.dart';
import 'package:timezone/standalone.dart' as tz;

final telegramService = GetIt.I.get<TelegramService>();
final schedulerService = GetIt.I.get<SchedulerService>();
final config = GetIt.I.get<ConfigService>();
final formatter = DateFormat('yyyy-MM-dd HH:mm');
final location = tz.getLocation('Europe/Kiev');

void notifyFeedingTime(SchedulerJob job) {
  telegramService.telegram.sendMessage(config.get('chatId'), '@${job.getFromUsername()} Пришло время кормежки',
      reply_markup: ReplyKeyboardMarkup(keyboard: [
        [KeyboardButton(text: 'Покормить жабу')]
      ], one_time_keyboard: true, resize_keyboard: true, selective: true));
}
