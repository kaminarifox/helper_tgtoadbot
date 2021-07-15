import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart';

import '../../common/types/enums.dart';
import 'scheduler.service.dart';
import 'scheduler_types.dart';
import 'package:timezone/standalone.dart' as tz;

import '../../common/services/mongo.service.dart';

final schedulerService = GetIt.I.get<SchedulerService>();
final formatter = DateFormat('yyyy-MM-dd HH:mm');
final location = tz.getLocation('Europe/Kiev');

final MongoService _mongo = GetIt.I.get<MongoService>();
final _subscribers = _mongo.db.collection('toadSubscribers');

String scheduleToadFeeding(TeleDartMessage message) {
  var matches = RegExp(r'((\d\d):(\d\d))').firstMatch(message.text);
  var hours = int.parse(matches?.group(2) as String);
  var minutes = int.parse(matches?.group(3) as String);

  var now = TZDateTime.now(location);
  var next = TZDateTime(location, now.year, now.month, now.day, hours, minutes);
  if (now.isAfter(next)) {
    next = TZDateTime.fromMillisecondsSinceEpoch(location,
        next.millisecondsSinceEpoch + Duration(hours: 24).inMilliseconds);
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

String feedToad(TeleDartMessage message) {
  return '';
}

Future<String> subscribeToad(TeleDartMessage message) async {
  await _subscribers.insertOne({
    'user_id': message.from.id,
    'user_name': message.from.first_name,
    'chat_id': message.chat.id
  });
  return 'Пипяу! Теперь ты подписан на рассылку, и я буду пинговать тебя, когда можно будет взять жабу.';
}

Future<String> unsubscribeToad(TeleDartMessage message, HelperCommand command) async {
  final ret = await _subscribers.deleteOne({
    'user_id': message.from.id,
    'chat_id': message.chat.id
  });

  if (ret.nRemoved > 0) {
    var msg;

    if (command == HelperCommand.assembleGang) {
      msg = 'Поздравляю! Я больше не буду пинговать тебя';
    } else {
      msg = 'Ок, я больше не буду пинговать тебя.';
    }

    return msg;
  } else {
    if (command != HelperCommand.assembleGang) {
      return 'Ало, ты и так не подписан!';
    } else {
      return '';
    }
  }
}

Future<String> toadSent(TeleDartMessage message) async {
  final subscribers = await _subscribers.find({'chat_id': message.chat.id});

  if (subscribers.length == 0) {
    return '';
  }

  final mentions = await subscribers.map((sub) {
    final user_id = sub["user_id"];
    final user_name = sub["user_name"];
    return '[${user_name}](tg://user?id=${user_id})';
  }).join(', ');

  return 'Эй, тут жаба!\n\n${mentions}';
}
