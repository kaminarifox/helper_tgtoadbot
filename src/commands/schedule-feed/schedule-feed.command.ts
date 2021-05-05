import { Command } from '../command';
import { Context, Telegraf } from 'telegraf';
import { MessageEntity, Update, User } from 'typegram';
import * as schedule from 'node-schedule';
import * as moment from 'moment';

export class ScheduleFeedCommand extends Command {
  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
  }

  init() {
    this.bot.hears(/^[Зз]апланировать (пир|кормежку) \d\d:\d\d$/, ctx => this.handle(ctx));
    this.bot.hears('Покормить жабу', ctx => this.handleAnswer(ctx));
  } 

  private handle(ctx) {
    const [scheduleHours, scheduleMinutes] = ctx.update.message.text.split(' ').pop().split(':');

    const nextTime = moment().hours(Number(scheduleHours)).minutes(Number(scheduleMinutes)).seconds(0);
    if (nextTime.isBefore(moment())) {
      nextTime.add(1, 'day');
    }

    this.botSchedule(nextTime.toDate(), ctx.update.message.message_id);
  }

  private handleAnswer(ctx) {
    if (ctx.update.message.reply_to_message.from.username === this.bot.botInfo.username) {
      const nextTime = moment().add(12, 'hours');
      this.botSchedule(nextTime.toDate(), ctx.update.message.message_id);
    }
  }

  private botSchedule(nextTime: Date, fromId: any) {
    const job = schedule.scheduleJob(nextTime, cb => {
      this.bot.telegram.sendMessage(process.env.CHAT_ID, 'Пришло время кормежки', {
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
