import * as dotenv from 'dotenv';

dotenv.config();

type ConfigRecord = Record<string, unknown>

export class Config {
  private static config: ConfigRecord = {
    apiToken: process.env.API_TOKEN,
    chatId: process.env.CHAT_ID,
    mongo: {
      host: process.env.MONGO_HOST,
      rootUsername: process.env.MONGO_ROOT_USERNAME,
      rootPassword: process.env.MONGO_ROOT_PASSWORD,
      agendaUsername: process.env.MONGO_AGENDA_USERNAME,
      agendaPassword: process.env.MONGO_AGENDA_PASSWORD,
      agendaAddress: `mongodb://${process.env.MONGO_AGENDA_USERNAME}:${process.env.MONGO_AGENDA_PASSWORD}@${process.env.MONGO_HOST}/agenda`,
      test: {
        test: ''
      }
    }
  };

  static get<T>(key: string): T {
    if (key.includes('.')) {
      return key.split('.').reduce((o,i) => o[i] as ConfigRecord, Config.config) as T;
    }

    return Config.config[key] as T;
  }
}
