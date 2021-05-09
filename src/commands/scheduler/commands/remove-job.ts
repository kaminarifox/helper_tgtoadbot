import { Agenda } from 'agenda';
import { HearContext } from '../../../types';
import { Message } from 'typegram';
import * as mongodb from 'mongodb';

export async function removeJob(agenda: Agenda, ctx: HearContext): Promise<Message.TextMessage> {
  const userId = ctx.from?.id;
  const jobId = ctx.match[1];

  const jobs = await agenda.jobs({
    '_id': new mongodb.ObjectId(jobId),
    'data.ctx.update.message.from.id': userId,
    'lastFinishedAt': null,
  }, {lastFinishedAt: -1});

  if (jobs.length === 1) {
    await jobs[0].remove();
    return ctx.reply(`Задача ${jobId} отменена`);
  }

  return ctx.reply('Нет!');
}
