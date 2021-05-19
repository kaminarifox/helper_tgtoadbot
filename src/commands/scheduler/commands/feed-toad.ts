import { Agenda } from 'agenda';
import * as moment from 'moment';
import { SchedulerCommand } from '../scheduler-command';
import { Context } from 'grammy';

export async function feedToad(agenda: Agenda, ctx: Context): Promise<unknown> {
  if (ctx.update.message?.reply_to_message?.from?.username === ctx.me.username) {
    const replyToMessage = ctx.update.message?.reply_to_message?.text;
    if (!replyToMessage) {
      throw new Error('feedToad: reply_to_message is undefined');
    }

    const addHours = /^пришло время пира$/ui.test(replyToMessage) ? 6 : 12;
    const nextTime = moment().add(addHours, 'hours').set('seconds', 0);

    // Prevent serialization errors
    const {api, ...clearedCtx} = ctx;
    await agenda.schedule(nextTime.toDate(), SchedulerCommand.ScheduleToadFeeding, {ctx: clearedCtx}).then();

    const replyMessage = addHours === 6 ? 'Следующий пир запланирован на ' : 'Следующая кормежка запланирована на ';

    return ctx.reply(replyMessage + nextTime.utcOffset(3).format('YYYY-MM-DD HH:mm'), {
      reply_to_message_id: ctx.update.message?.message_id,
      reply_markup: {
        selective: true,
        remove_keyboard: true,
      }
    });
  }
}

