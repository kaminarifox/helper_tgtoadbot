import { SchedulerModule } from "./sheduler/scheduler.module";
import { InlineModule } from "./inline/inline.module";
import { Telegraf } from "telegraf";
import { BotModule } from "./bot-module";

export class BotModules {
  static init(bot: Telegraf) {
    const modules: {new(): BotModule;}[] = [
      InlineModule,
      // SchedulerModule,
      // Modules imports
    ];

    for (const mod of modules) {
      const instance = new mod;
      instance.register(bot);
    }
  }
}
