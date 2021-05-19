import { Agenda, Job } from 'agenda';
import { SchedulerCommand } from '../scheduler-command';
import { Config } from '../../../config';
import { Bot, Context } from 'grammy';
import { FeedType } from '../../../types';

export async function scheduleToadFeedingJob(agenda: Agenda, bot: Bot) {
  agenda.define(SchedulerCommand.ScheduleToadFeeding, async (job: Job) => {
    const { ctx } = job.attrs.data as { ctx: Context };
    const text = ctx.update.message?.text || '';
    const replyToText = ctx.update.message?.reply_to_message?.text || '';

    let feedType: FeedType | undefined;
    let match = text.match(/^запланировать (пир|кормежку) \d\d:\d\d$/ui);
    if (match && match[1]) {
      feedType = match[1] as FeedType;
    } else if (replyToText && /^(покормить|откормить) жабу$/ui.test(text)) {
      match = replyToText.match(/^пришло время (пира|кормежки)/ui);
      if (match && match[1]) {
        feedType = match[1] === 'кормежки' ? FeedType.FeedStandard : FeedType.FeedPrime;
      }
    } else {
      throw new Error('Kwa :|');
    }

    const replyMessage = (feedType === FeedType.FeedStandard ? 'Пришло время кормёжки' : 'Пришло время пира');
    return bot.api.sendMessage(Config.get('chatId'), replyMessage, {
      reply_to_message_id: ctx.update.message?.message_id,
      reply_markup: {
        selective: true,
        one_time_keyboard: true,
        force_reply: true,
        resize_keyboard: true,
        keyboard: [[{text: 'Покормить жабу'}]]
      }
    });
  });
}
