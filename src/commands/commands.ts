import { InlineCommand } from "./inline/inline.command";
import { Context, Telegraf } from "telegraf";
import { Update } from "typegram";
import { ScheduleFeedCommand } from "./scheduler/schedule-feed.command";

export class Commands {
  static commands: {new(bot: Telegraf<Context<Update>>): any}[] = [
    InlineCommand,
    ScheduleFeedCommand,
  ];

  static init(bot: Telegraf<Context<Update>>) {
    for (const command of Commands.commands) {
      (new command(bot)).init();
    }
  }
}
