import { Agenda } from "agenda";
import { HearContext } from "../../../types";
import * as moment from "moment";
import { SchedulerCommand } from "../scheduler-command";

export async function feedToad(agenda: Agenda, ctx: HearContext) {
  if (ctx.update.message.reply_to_message?.from.username === ctx.botInfo?.username) {
    const addHours = /^пришло время пира$/ui.test(ctx.update.message.reply_to_message.text) ? 6 : 12;
    const nextTime = moment().add(addHours, 'hours');

    const {tg, ...clearedCtx} = ctx;
    await agenda.schedule(nextTime.toDate(), SchedulerCommand.ScheduleToadFeeding, {ctx: clearedCtx}).then()

    const replyMessage = addHours === 6 ? 'Следующий пир запланирован на ' : 'Следующая кормежка запланирована на ';
    return ctx.reply(replyMessage + nextTime.utcOffset(3).format('YYYY-MM-DD HH:mm'), {
      reply_to_message_id: ctx.message?.message_id,
      reply_markup: {
        selective: true,
        remove_keyboard: true
      }
    });
  }
}

