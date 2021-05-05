import { Command } from '../command';
import { Context, Telegraf } from 'telegraf';
import { Update } from 'typegram';
import * as schedule from 'node-schedule';
import * as moment from 'moment';
import { Config } from "../../config";

export class ScheduleFeedCommand extends Command {
  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
  }

  init() {
    this.bot.hears(/^[Зз]апланировать (пир|кормежку) \d\d:\d\d$/, ctx => this.handle(ctx));
    this.bot.hears('Покормить жабу', ctx => this.handleAnswer(ctx));
  }

  private handle(ctx: Context<Update> & {update: any}) {
    const [scheduleHours, scheduleMinutes] = ctx.update.message.text.split(' ').pop().split(':');

    const nextTime = moment().utcOffset(3).hours(Number(scheduleHours)).minutes(Number(scheduleMinutes)).seconds(0);
    if (nextTime.isBefore(moment())) {
      nextTime.add(1, 'day');
    }

    this.botSchedule(nextTime.toDate(), ctx.update.message.message_id);
    ctx.reply('Кормежка запланирована на ' + nextTime.format('YYYY-MM-DD HH:mm'));
  }

  private handleAnswer(ctx: Context<Update> & {update: any}) {
    if (ctx.update.message.reply_to_message?.from.username === this.bot.botInfo?.username) {
      const nextTime = moment().add(12, 'hours');
      this.botSchedule(nextTime.toDate(), ctx.update.message.message_id);
      ctx.reply('Кормежка запланирована на ' + nextTime.format('YYYY-MM-DD HH:mm'));
    }
  }

  private botSchedule(nextTime: Date, fromId: any) {
    const job = schedule.scheduleJob(nextTime, cb => {
      this.bot.telegram.sendMessage(Config.get('chatId'), 'Пришло время кормежки', {
        reply_to_message_id: fromId,
        reply_markup: {
          one_time_keyboard: true,
          resize_keyboard: true,
          keyboard: [[{text: 'Покормить жабу'}]]
        }
      });
    })
  }
}
