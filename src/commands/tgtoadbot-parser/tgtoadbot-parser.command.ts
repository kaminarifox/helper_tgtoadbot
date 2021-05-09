import { Command } from "../command";
import { Context, Telegraf } from "telegraf";
import { Update } from "typegram";

export class TgtoadbotParserCommand extends Command {
  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
  }

  init() {
    // this.bot.hears('Жаба инфо', ctx => {
    //   console.log(ctx);
    //   ctx.message.
    // })
  }
}
