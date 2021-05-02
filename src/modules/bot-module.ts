import { Telegraf } from "telegraf";

export class BotModule {
  register(bot: Telegraf) {
    throw new Error('Module registration not implemented');
  }
}
