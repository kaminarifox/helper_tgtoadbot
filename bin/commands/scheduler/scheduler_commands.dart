import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';

import '../../services/scheduler.service.dart';
import '../../services/telegram.service.dart';
import '../../types/enums.dart';
import '../../types/scheduler_job.dart';
import 'scheduler_patterns.dart';

class SchedulerCommand {
  late final SchedulerService schedulerService;

  SchedulerCommand() {
    schedulerService = GetIt.I.get<SchedulerService>();
    final telegramService  = GetIt.I.get<TelegramService>();

    telegramService.teledart.onMessage().listen((message) {
      _handleMessage(message);
    });

    schedulerService.jobStream.stream.listen((job) {
      telegramService.teledart.telegram.sendMessage(
          job.data?['chat']['id'],
          'Hello!', );
    });
  }

  void _handleMessage(TeleDartMessage message) {
    schedulerPatterns.forEach((element) {
      if ((element['pattern'] as RegExp).hasMatch(message.text)) {
        _runCommand(element['command'] as HelperCommand, message);
      }
    });
  }

  void _runCommand(HelperCommand command, TeleDartMessage message) {
    switch (command) {
      case HelperCommand.scheduleToadFeeding:
        var job = SchedulerJob(
          command,
          DateTime.now().add(Duration(seconds: 10)).millisecondsSinceEpoch,
          JobStatus.active,
          message.toJson(),
        );

        schedulerService.schedule(job);
        break;
      default:
        break;
    }
  }
}
