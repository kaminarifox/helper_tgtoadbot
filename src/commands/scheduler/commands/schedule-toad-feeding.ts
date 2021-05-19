import * as moment from 'moment';
import { Agenda } from 'agenda';
import { SchedulerCommand } from '../scheduler-command';
import { Context } from 'grammy';
import { FeedType } from '../../../types';

export async function scheduleToadFeeding(agenda: Agenda, ctx: Context): Promise<unknown> {
  const [, feedType, time] = ctx.match as RegExpMatchArray;
  const [scheduleHours, scheduleMinutes] = time.split(':');
  const nextTime = moment().utcOffset(3)
    .hours(Number(scheduleHours)).minutes(Number(scheduleMinutes)).seconds(0);

  if (nextTime.isBefore(moment())) {
    nextTime.add(1, 'day');
  }

  // Prevent serialization errors
  const {api, ...clearedCtx} = ctx;
  await agenda.schedule(nextTime.toDate(), SchedulerCommand.ScheduleToadFeeding, {ctx: clearedCtx});

  if (feedType === FeedType.FeedPrime) {
    return ctx.reply('Пир запланирован на ' + nextTime.format('YYYY-MM-DD HH:mm'), {
      reply_to_message_id: ctx.update.message?.message_id
    });
  }

  return ctx.reply('Кормежка запланирована на ' + nextTime.format('YYYY-MM-DD HH:mm'), {
    reply_to_message_id: ctx.update.message?.message_id
  });
}
