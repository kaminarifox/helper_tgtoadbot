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

Future<void> scheduleToadFeeding(TeleDartMessage message) async {
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
  message.reply('Кормежка запланирована на ${formatter.format(next)}');
}

Future<void> feedToad(TeleDartMessage message) async {
  return;
}

Future<void> subscribeToad(TeleDartMessage message) async {
  await _subscribers.insertOne({
    'user_id': message.from.id,
    'user_name': message.from.first_name,
    'chat_id': message.chat.id
  });

  message.reply(
    'Пипяу! Теперь ты подписан на рассылку,'
    + ' и я буду пинговать тебя, когда можно будет взять жабу.'
  );
}

Future<void> unsubscribeToad(TeleDartMessage message, HelperCommand command) async {
  final ret = await _subscribers.deleteOne({
    'user_id': message.from.id,
    'chat_id': message.chat.id
  });

  var msg = '';

  if (ret.nRemoved > 0) {
    if (command == HelperCommand.assembleGang) {
      msg = 'Поздравляю! Я больше не буду пинговать тебя';
    } else {
      msg = 'Ок, я больше не буду пинговать тебя.';
    }
  } else {
    if (command != HelperCommand.assembleGang) {
      msg = 'Ало, ты и так не подписан!';
    } else {
      return;
    }
  }

  message.reply(msg);
}

Future<void> toadSent(TeleDartMessage message) async {
  final subscribers = await _subscribers.find({'chat_id': message.chat.id});

  final mentions = subscribers.map((sub) {
    final user_id = sub["user_id"];
    final user_name = sub["user_name"];
    return '[${user_name}](tg://user?id=${user_id})';
  });
  final mentionsStr = await mentions.join(', ');

  if (mentionsStr.length == 0) {
    return;
  }

  message.reply(
    'Эй, тут жаба!\n\n${mentionsStr}',
    parse_mode: 'Markdown',
    reply_markup: ReplyKeyboardMarkup(keyboard: [
      [KeyboardButton(text: 'Взять жабу')]
    ], one_time_keyboard: true, resize_keyboard: true, selective: true)
  );
}
