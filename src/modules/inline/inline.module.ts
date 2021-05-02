import { Telegraf } from "telegraf";
import { queryResults } from "./query-results";
import { BotModule } from "../bot-module";

export class InlineModule extends BotModule {
  register(bot: Telegraf) {
    this.init(bot);
  }

  init(bot: Telegraf) {
    bot.on('inline_query', (ctx) => {
      const query = ctx.inlineQuery.query;

      const filtered = queryResults.filter(v => {
        return (new RegExp(query, 'gium').test(v.title));
      })

      ctx.answerInlineQuery(filtered)
    })
  }
}
