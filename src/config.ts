require('dotenv').config()

export class Config {
  private static config: Record<string, any> = {
    apiToken: process.env.API_TOKEN as string,
    chatId: process.env.CHAT_ID as string,
    mongo: {
      host: process.env.MONGO_HOST as string,
      rootUsername: process.env.MONGO_ROOT_USERNAME as string,
      rootPassword: process.env.MONGO_ROOT_PASSWORD as string,
      agendaUsername: process.env.MONGO_AGENDA_USERNAME as string,
      agendaPassword: process.env.MONGO_AGENDA_PASSWORD as string,
      agendaAddress: `mongodb://${process.env.MONGO_AGENDA_USERNAME}:${process.env.MONGO_AGENDA_PASSWORD}@${process.env.MONGO_HOST}/agenda`,
    }
  };

  static get<T>(key: string): T {
    if (key.includes('.')) {
      return key.split('.').reduce((o,i)=>o[i], Config.config) as T;
    }

    return Config.config[key] as T;
  }
}
