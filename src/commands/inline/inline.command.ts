import { queryResults } from './query-results';
import { Command } from '../command';
import * as ru from 'convert-layout/ru';
import { Bot } from 'grammy';

export class InlineCommand extends Command {
  constructor(bot: Bot) {
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

      return ctx.answerInlineQuery(filtered);
    });
  }
}
