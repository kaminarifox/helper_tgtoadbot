import { Telegraf } from 'telegraf';
import { Services } from "./services/services";
import { Commands } from "./commands/commands";
import { Config } from "./config";

async function bootstrap() {
  const bot = new Telegraf(Config.get('apiToken'));

  Services.init();
  Commands.init(bot);

  return bot.launch();
}
bootstrap().then(() => {
  console.log('Bot is running!');
});
