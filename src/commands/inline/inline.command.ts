import { Context, Telegraf } from 'telegraf';
import { queryResults } from './query-results';
import { Command } from '../command';
import { Update } from 'typegram';
import * as ru from 'convert-layout/ru';

export class InlineCommand extends Command {
  constructor(bot: Telegraf<Context<Update>>) {
    super(bot);
  }

  init() {
    this.bot.on('inline_query', (ctx) => {
      let query = ctx.inlineQuery.query;

      if (/^[a-z]+$/ui.test(query)) {
        query = ru.fromEn(query);
      }

      const filtered = queryResults.filter(v => {
        return (new RegExp(query, 'gium').test(v.title));
      });

      ctx.answerInlineQuery(filtered);
    });
  }
}
