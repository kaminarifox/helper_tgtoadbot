import { Agenda } from 'agenda';
import * as mongodb from 'mongodb';
import { Context } from 'grammy';

export async function removeJob(agenda: Agenda, ctx: Context): Promise<unknown> {
  const userId = ctx.from?.id;
  const jobId = (ctx.match as RegExpMatchArray)[1];

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
