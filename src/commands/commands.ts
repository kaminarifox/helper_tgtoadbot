import { InlineCommand } from "./inline/inline.command";
import { Context, Telegraf } from "telegraf";
import { ScheduleFeedCommand } from "./schedule-feed/schedule-feed.command";
import { Update } from "typegram";

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
