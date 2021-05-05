import { Command } from '../command';
import { Context, Telegraf } from 'telegraf';
import { Update } from 'typegram';
import * as moment from 'moment';
import { Config } from "../../config";
import { Agenda, Job } from "agenda";

export class ScheduleFeedCommand extends Command {
  agenda: Agenda;

  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
    this.agenda = new Agenda({ db: {address: Config.get('mongo.agendaAddress')} });
  }

  init() {
    this.agenda.define('feedToad', async (job: Job) => {
      const { fromId } = job.attrs.data as { fromId: number };
      await this.bot.telegram.sendMessage(Config.get('chatId'), 'Пришло время кормежки', {
        reply_to_message_id: fromId,
        reply_markup: {
          selective: true,
          one_time_keyboard: true,
          resize_keyboard: true,
          keyboard: [[{text: 'Покормить жабу'}]]
        }
      })
    });
    this.agenda.start();

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
      ctx.reply('Следующая кормежка запланирована на ' + nextTime.format('YYYY-MM-DD HH:mm'), {
        reply_to_message_id: ctx.message?.message_id,
        reply_markup: {
          selective: true,
          remove_keyboard: true
        }
      });
    }
  }

  private botSchedule(nextTime: Date, fromId: any): Promise<Job> {
    return this.agenda.schedule(nextTime, 'feedToad', {fromId});
  }
}
