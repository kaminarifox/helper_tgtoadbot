import { Agenda, Job } from 'agenda';
import { SchedulerCommand } from '../scheduler-command';
import { Config } from '../../../config';
import { Bot, Context } from 'grammy';
import { FeedType } from '../../../types';

export async function scheduleToadFeedingJob(agenda: Agenda, bot: Bot) {
  agenda.define(SchedulerCommand.ScheduleToadFeeding, async (job: Job) => {
    const { ctx } = job.attrs.data as { ctx: Context };
    const replyToMessage = ctx.update?.message?.reply_to_message?.text || ctx.update.message?.text;
    if (!replyToMessage) {
      throw new Error('reply_to_message is undefined');
    }

    let feedType = FeedType.FeedStandard;
    if (/^запланировать пир/ui.test(replyToMessage) || /^пришло время пира$/.test(replyToMessage)) {
      feedType = FeedType.FeedPrime;
    }

    const replyMessage = (feedType === FeedType.FeedStandard ? 'Пришло время кормёжки' : 'Пришло время пира');

    return bot.api.sendMessage(Config.get('chatId'), replyMessage, {
      reply_to_message_id: ctx.update.message?.reply_to_message?.message_id || ctx.update.message?.message_id,
      reply_markup: {
        selective: true,
        one_time_keyboard: true,
        resize_keyboard: true,
        keyboard: [[{text: 'Покормить жабу'}]]
      }
    });
  });
}
