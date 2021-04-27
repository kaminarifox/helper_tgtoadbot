import { Context, Telegraf } from "telegraf";
import { Update } from "typegram";
import { BaseScheduler } from "./shedulers/base.scheduler";

export class HelperScheduler {
  private bot: Telegraf<Context<Update>>
  constructor(bot: Telegraf) {
    this.bot = bot;
  }

  next(scheduler: BaseScheduler) {

  }
}
