import { Command } from '../command';
import { Context, Telegraf } from 'telegraf';
import { Update } from 'typegram';
import { Config } from "../../config";
import { Agenda, Job } from "agenda";
import { SchedulerCommand } from "./scheduler-command";
import { HearContext } from "../../types";
import { scheduleToadFeeding, scheduleToadFeedingJob } from "./commands/schedule-toad-feeding";
import { feedToad } from "./commands/feed-toad";

export class ScheduleFeedCommand extends Command {
  agenda: Agenda;

  botHearsMap: Record<string, {pattern: RegExp, handler: (agenda: Agenda, ctx: HearContext) => {}}> = {
    [SchedulerCommand.ScheduleToadFeeding]: {
      pattern: /^запланировать (пир|кормежку) (\d\d:\d\d$)/ui,
      handler: scheduleToadFeeding
    },
    [SchedulerCommand.FeedToad]: {
      pattern: /^покормить жабу$/ui,
      handler: feedToad,
    },
  };

  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
    this.agenda = new Agenda({ db: {address: Config.get('mongo.agendaAddress')} });
  }

  async init() {
    await this.defineHears()
    await this.defineJobs();

    return this.agenda.start();
  }

  private async defineHears() {
    for (const [command, {handler, pattern}] of Object.entries(this.botHearsMap)) {
      this.bot.hears(pattern, ctx => {
        handler(this.agenda, ctx);
      })
    }
  }

  private async defineJobs() {
    await scheduleToadFeedingJob(this.agenda, this.bot);
  }
}
