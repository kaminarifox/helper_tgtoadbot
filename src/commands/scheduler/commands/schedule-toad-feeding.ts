import * as moment from "moment";
import { HearContext } from "../../../types";
import { Agenda, Job } from "agenda";
import { SchedulerCommand } from "../scheduler-command";
import { Telegraf } from "telegraf";
import { Config } from "../../../config";

enum FeedType {
  FeedStandard = 'кормежку',
  FeedPrime = 'пир'
}

export async function scheduleToadFeeding(agenda: Agenda, ctx: HearContext) {
  const [message, feedType, time] = ctx.match;
  const [scheduleHours, scheduleMinutes] = time.split(':');
  const nextTime = moment().utcOffset(3)
    .hours(Number(scheduleHours)).minutes(Number(scheduleMinutes)).seconds(0);

  if (nextTime.isBefore(moment())) {
    nextTime.add(1, 'day');
  }

  // Prevent serialization errors
  const {tg, ...clearedCtx} = ctx;
  await agenda.schedule(nextTime.toDate(), SchedulerCommand.ScheduleToadFeeding, {ctx: clearedCtx})

  if (feedType === FeedType.FeedStandard) {
    return ctx.reply('Кормежка запланирована на ' + nextTime.format('YYYY-MM-DD HH:mm'));
  } else {
    return ctx.reply('Пир запланирован на ' + nextTime.format('YYYY-MM-DD HH:mm'));
  }
}

export async function scheduleToadFeedingJob(agenda: Agenda, bot: Telegraf) {
    agenda.define(SchedulerCommand.ScheduleToadFeeding, async (job: Job) => {
      const { ctx } = job.attrs.data as { ctx: HearContext };
      const [message, feedType, time] = ctx.match;

      const replyMessage = (feedType === FeedType.FeedStandard ? 'Пришло время кормежки' : 'Пришло время пира');
      await bot.telegram.sendMessage(Config.get('chatId'), replyMessage, {
        reply_to_message_id: ctx?.update.message.message_id,
        reply_markup: {
          selective: true,
          one_time_keyboard: true,
          resize_keyboard: true,
          keyboard: [[{text: 'Покормить жабу'}]]
        }
      })
    });
}
