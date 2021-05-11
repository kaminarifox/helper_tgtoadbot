import { Command } from '../command';
import { Bot, Context } from 'grammy';

export class TgtoadbotParserCommand extends Command {
  constructor(bot: Bot) {
    super(bot);
  }

  init() {
    // this.bot.hears('Жаба инфо', ctx => {
    //   console.log(ctx);
    //   ctx.message.
    // })
  }
}
