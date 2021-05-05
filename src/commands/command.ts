import { Context, Telegraf } from "telegraf";
import { Update } from "typegram";

export class Command {
  protected bot: Telegraf<Context<Update>>

  constructor(bot: Telegraf<Context<Update>>) {
    this.bot = bot;
  }

  static init() {
    throw new Error('init() method not implemented');
  }
}
