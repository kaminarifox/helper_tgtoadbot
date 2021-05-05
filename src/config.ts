require('dotenv').config()

export class Config {
  private static config: Record<string, any> = {
    apiToken: process.env.API_TOKEN as string,
    chatId: process.env.CHAT_ID as string,
  }

  static get<T>(key: string): T {
    return Config.config[key] as T;
  }
}
