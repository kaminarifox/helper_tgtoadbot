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
        'url': env['MONGO_URL'],
      }
    };
  }

  T get<T>(String key) {
    return gato.get<T>(_config, key);
  }
}
