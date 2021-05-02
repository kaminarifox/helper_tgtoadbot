import { Context, Telegraf } from "telegraf";
import { BotModule } from "../bot-module";

export class SchedulerModule extends BotModule {
  register(bot: Telegraf) {
    this.init(bot)
  }

  init(bot: Telegraf) {
    bot.hears('Запланировать кормежку', (ctx) => {
      ctx.reply('Настало время покормить свою жабку 🐸', {
        reply_markup: {keyboard: [[{text: 'Покормить жабу'}]], one_time_keyboard: true, resize_keyboard: true}
      })
    })
  }
}
