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
        await scheduleToadFeeding(message);
        break;
      case HelperCommand.feedToad:
        await feedToad(message);
        break;
      case HelperCommand.subscribeToad:
        await subscribeToad(message);
        break;
      case HelperCommand.unsubscribeToad:
      case HelperCommand.assembleGang:
        await unsubscribeToad(message, command);
        break;
      case HelperCommand.toadSent:
        toadSent(message);
        break;
      default:
        break;
    }
  }
}
