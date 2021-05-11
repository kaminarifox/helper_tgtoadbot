import { Agenda } from 'agenda';
import * as moment from 'moment';
import { SchedulerCommand } from '../scheduler-command';
import { Context } from 'grammy';

const commandTitleMap: Record<string, string> = {
  [SchedulerCommand.ScheduleToadFeeding]: 'Кормежка',
};

export async function jobList(agenda: Agenda, ctx: Context): Promise<unknown> {
  const userId = ctx.from?.id;
  const jobs = await agenda.jobs({
    'data.ctx.update.message.from.id': userId,
    'lastFinishedAt': null,
  }).then(jobs => {
    return jobs.sort((a, b) => moment(a.attrs.nextRunAt).unix() - moment(b.attrs.nextRunAt).unix());
  });

  if (jobs.length) {
    const replyMessage = jobs.map((job, index) => {
      const nextTime = moment(job.attrs.nextRunAt).utcOffset(3).format('YYYY-MM-DD HH:mm');

      const message = [
        '# ' + (index + 1),
        'ID: ' + job.attrs._id,
        'Задача: ' + commandTitleMap[job.attrs.name],
        nextTime + '\n',
      ];

      return message.join('\n');
    }).join('\n');

    return ctx.reply(replyMessage, {entities: [{type: 'pre', offset: 0, length: replyMessage.length}]});
  }

  return ctx.reply('У жабки нет планов ☹️');
}
