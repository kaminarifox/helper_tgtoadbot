import { Bot, Context } from 'grammy';

export class Command {
  protected bot: Bot;

  constructor(bot: Bot) {
    this.bot = bot;
  }

  init() {
    throw new Error('init() method not implemented');
  }
}
