import 'package:gato/gato.dart' as gato;
import 'package:dotenv/dotenv.dart' show load, env;

class ConfigService {
  var _config;

  ConfigService() {
    load();
    _config = {
      'apiToken': env['API_TOKEN'],
      'chatId': env['CHAT_ID'],
      'mongo': {
        'host': env['MONGO_HOST'],
        'rootUsername': env['MONGO_ROOT_USERNAME'],
        'rootPassword': env['MONGO_ROOT_PASSWORD'],
        'agendaUsername': env['MONGO_AGENDA_USERNAME'],
        'agendaPassword': env['MONGO_AGENDA_PASSWORD'],
        'agendaAddress': 'mongodb://${env['MONGO_AGENDA_USERNAME']}:${env['MONGO_AGENDA_PASSWORD']}@${env['MONGO_HOST']}/agenda',
      }
    };
  }

  T get<T>(String key) {
    return gato.get<T>(_config, key);
  }
}
