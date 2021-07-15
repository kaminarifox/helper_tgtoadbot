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

  void _handleIncomingMessage(TeleDartMessage message) {
    schedulerPatterns.forEach((element) {
      if (element.pattern.hasMatch(message.text)) {
        _executeCommand(element.command, message);
      }
    });
  }

  void _handleJob(SchedulerJob job) {
    notifyFeedingTime(job);
  }

  void _executeCommand(HelperCommand command, TeleDartMessage message) {
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
        final responseMessage = subscribeToad(message);
        message.reply(responseMessage);
        break;
      case HelperCommand.unsubscribeToad:
        final responseMessage = unsubscribeToad(message);
        message.reply(responseMessage);
        break;
      case HelperCommand.toadSent:
        final responseMessage = toadSent(message);
        message.reply(responseMessage);
        break;
      default:
        break;
    }
  }

  // void _sendResponse(HelperCommand, ) {
  //   Message.fromJson({}).
  //
  // }
}
