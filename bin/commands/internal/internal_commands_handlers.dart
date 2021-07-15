import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:teledart/model.dart';

import '../../common/services/mongo.service.dart';

final MongoService _mongo = GetIt.I.get<MongoService>();
final _userCollection = _mongo.db.collection('tgUser');

void prime_on(TeleDartMessage message) async {
  final user = await _userCollection.findOne({'user_id': message.from.id});

  if (user != null) {
    await _userCollection.update({'user_id': message.from.id}, modify.set('is_prime', true));
  } else {
    await _userCollection.insertOne({'user_id': message.from.id, 'is_prime': true});
  }

  message.reply('Prime режим включен');
}

void prime_off(TeleDartMessage message) async {
  final user = await _userCollection.findOne({'user_id': message.from.id});

  if (user != null) {
    await _userCollection.update({'user_id': message.from.id}, modify.set('is_prime', false));
  } else {
    await _userCollection.insertOne({'user_id': message.from.id, 'is_prime': false});
  }

  message.reply('Prime режим отключен');
}

