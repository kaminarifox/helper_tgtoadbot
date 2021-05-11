import { Command } from '../command';
import { Config } from '../../config';
import { Agenda } from 'agenda';
import { SchedulerCommand } from './scheduler-command';
import { scheduleToadFeeding } from './commands/schedule-toad-feeding';
import { feedToad } from './commands/feed-toad';
import { jobList } from './commands/job-list';
import { removeJob } from './commands/remove-job';
import { scheduleToadFeedingJob } from './jobs/schedule-toad-feeding-job';
import { Bot, Context } from 'grammy';

export class ScheduleFeedCommand extends Command {
  agenda: Agenda;

  botHearsMap: Record<string, {pattern: RegExp, handler: (agenda: Agenda, ctx: Context) => Promise<unknown>}> = {
    [SchedulerCommand.JobList]: {
      pattern: /^мо[её] расписание$/ui,
      handler: jobList,
    },
    [SchedulerCommand.RemoveJob]: {
      pattern: /^отменить задачу ([a-z0-9]+)$/ui,
      handler: removeJob,
    },
    [SchedulerCommand.ScheduleToadFeeding]: {
      pattern: /^запланировать (пир|кормежку) (\d\d:\d\d$)/ui,
      handler: scheduleToadFeeding
    },
    [SchedulerCommand.FeedToad]: {
      pattern: /^покормить жабу$/ui,
      handler: feedToad,
    },
  };

  constructor(bot: Bot<Context>) {
    super(bot);
    this.agenda = new Agenda({ db: {address: Config.get('mongo.agendaAddress')} });
  }

  async init(): Promise<unknown> {
    await this.defineHears();
    await this.defineJobs();

    return this.agenda.start();
  }

  private async defineHears() {
    for (const [command, {handler, pattern}] of Object.entries(this.botHearsMap)) {
      this.bot.hears(pattern, ctx => {
        handler(this.agenda, ctx);
      });
    }
  }

  private async defineJobs() {
    await scheduleToadFeedingJob(this.agenda, this.bot);
  }
}
