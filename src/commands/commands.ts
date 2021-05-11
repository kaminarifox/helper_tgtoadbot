import { InlineCommand } from './inline/inline.command';
import { ScheduleFeedCommand } from './scheduler/schedule-feed.command';
import { Bot, Context } from 'grammy';

export class Commands {
  static commands: {new(bot: Bot<Context>): any}[] = [
    InlineCommand,
    ScheduleFeedCommand,
  ];

  static init(bot: Bot<Context>) {
    for (const command of Commands.commands) {
      (new command(bot)).init();
    }
  }
}
