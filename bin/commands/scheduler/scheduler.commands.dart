import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';

import '../../common/services/telegram.service.dart';
import '../../common/types/enums.dart';
import 'scheduler.service.dart';
import 'scheduler_job_handlers.dart';
import 'scheduler_patterns.dart';
import 'scheduler_message_handlers.dart';
import 'scheduler_types.dart';

class SchedulerCommands {
  late final SchedulerService schedulerService;

  SchedulerCommands() {
    schedulerService = GetIt.I.get<SchedulerService>();
    final telegramService  = GetIt.I.get<TelegramService>();

    schedulerPatterns.forEach((pattern) {
      telegramService.teledart.onMessage(keyword: pattern.pattern)
          .listen(_handleIncomingMessage);
    });

    schedulerService.jobStream.stream.listen(_handleJob);
  }

  Future<void> _handleIncomingMessage(TeleDartMessage message) async {
    schedulerPatterns.forEach((element) async {
      if (element.pattern.hasMatch(message.text)) {
        await _executeCommand(element.command, message);
      }
    });
  }

  void _handleJob(SchedulerJob job) {
    notifyFeedingTime(job);
  }

  Future<void> _executeCommand(HelperCommand command, TeleDartMessage message) async {
    switch (command) {
      case HelperCommand.scheduleToadFeeding:
        final responseMessage = scheduleToadFeeding(message);
        message.reply(responseMessage);
        break;
      case HelperCommand.feedToad:
        final responseMessage = feedToad(message);
        message.reply(responseMessage);
        break;
      case HelperCommand.subscribeToad:
        final responseMessage = await subscribeToad(message);
        message.reply(responseMessage);
        break;
      case HelperCommand.unsubscribeToad:
      case HelperCommand.assembleGang:
        final responseMessage = await unsubscribeToad(message, command);
        if (responseMessage.length > 0) {
          message.reply(responseMessage);
        }
        break;
      case HelperCommand.toadSent:
        final responseMessage = await toadSent(message);
        if (responseMessage.length > 0) {
          message.reply(
            responseMessage,
            parse_mode: 'Markdown',
            reply_markup: ReplyKeyboardMarkup(keyboard: [
              [KeyboardButton(text: 'Взять жабу')]
            ], one_time_keyboard: true, resize_keyboard: true, selective: true)
          );
        }
        break;
      default:
        break;
    }
  }
}
