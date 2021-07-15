import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart';

import '../../common/types/enums.dart';
import 'scheduler.service.dart';
import 'scheduler_types.dart';
import 'package:timezone/standalone.dart' as tz;

final schedulerService = GetIt.I.get<SchedulerService>();
final formatter = DateFormat('yyyy-MM-dd HH:mm');
final location = tz.getLocation('Europe/Kiev');

String scheduleToadFeeding(TeleDartMessage message) {
  var matches = RegExp(r'((\d\d):(\d\d))').firstMatch(message.text);
  var hours = int.parse(matches?.group(2) as String);
  var minutes = int.parse(matches?.group(3) as String);

  var now = TZDateTime.now(location);
  var next = TZDateTime(location, now.year, now.month, now.day, hours, minutes);
  if (now.isAfter(next)) {
    next = TZDateTime.fromMillisecondsSinceEpoch(location,
        next.millisecondsSinceEpoch + 86400000);
  }

  var job = SchedulerJob(
    HelperCommand.scheduleToadFeeding,
    next.millisecondsSinceEpoch,
    JobStatus.active,
    message.toJson(),
  );

  schedulerService.schedule(job);

  return 'Кормежка запланирована на ' + formatter.format(next);
}

String feedToad(TeleDartMessage messsage) {
  return '';
}

String subscribeToad(TeleDartMessage messsage) {
  // TODO: add user to subscription
  return 'Ты подписался на рассылку, я буду пинговать тебя, когда в беседу пришлют жабу.';
}

String unsubscribeToad(TeleDartMessage messsage) {
  // TODO: remove user from subscription
  return 'Ок, я больше не буду пинговать тебя.';
}

String toadSent(TeleDartMessage messsage) {
  return 'Эй, тут жаба!';  // TODO: add user mentions
}
